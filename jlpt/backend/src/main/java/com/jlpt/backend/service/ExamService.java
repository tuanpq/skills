package com.jlpt.backend.service;

import com.jlpt.backend.dto.exam.*;
import com.jlpt.backend.entity.*;
import com.jlpt.backend.exception.BadRequestException;
import com.jlpt.backend.exception.ResourceNotFoundException;
import com.jlpt.backend.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ExamService {

    private final ExamRepository examRepository;
    private final ExamQuestionRepository examQuestionRepository;
    private final AttemptRepository attemptRepository;
    private final AttemptAnswerRepository attemptAnswerRepository;
    private final ChoiceRepository choiceRepository;

    public List<ExamSummaryResponse> listExams(JlptLevel level, SkillType skillType) {
        List<Exam> exams = skillType != null
                ? examRepository.findByLevelAndSkillType(level, skillType)
                : examRepository.findByLevel(level);
        return exams.stream()
                .map(exam -> ExamSummaryResponse.from(exam, examQuestionRepository.findByExamIdOrderByDisplayOrderAsc(exam.getId()).size()))
                .toList();
    }

    @Transactional(readOnly = true)
    public ExamDetailResponse getExam(Long examId) {
        Exam exam = getExamOrThrow(examId);
        List<QuestionForAttemptResponse> questions = examQuestionRepository.findByExamIdOrderByDisplayOrderAsc(examId).stream()
                .map(ExamQuestion::getQuestion)
                .map(QuestionForAttemptResponse::from)
                .toList();
        return ExamDetailResponse.from(exam, questions);
    }

    @Transactional
    public AttemptResponse startAttempt(Long examId, User user) {
        Exam exam = getExamOrThrow(examId);
        List<ExamQuestion> examQuestions = examQuestionRepository.findByExamIdOrderByDisplayOrderAsc(examId);
        if (examQuestions.isEmpty()) {
            throw new BadRequestException("Exam has no questions configured: " + examId);
        }
        int maxScore = examQuestions.stream().mapToInt(ExamQuestion::getPoints).sum();

        Attempt attempt = Attempt.builder()
                .user(user)
                .exam(exam)
                .status(AttemptStatus.IN_PROGRESS)
                .startedAt(Instant.now())
                .maxScore(maxScore)
                .build();
        attemptRepository.save(attempt);

        List<QuestionForAttemptResponse> questions = examQuestions.stream()
                .map(ExamQuestion::getQuestion)
                .map(QuestionForAttemptResponse::from)
                .toList();
        return AttemptResponse.from(attempt, questions);
    }

    @Transactional(readOnly = true)
    public AttemptResponse getAttempt(Long attemptId, User user) {
        Attempt attempt = attemptRepository.findById(attemptId)
                .orElseThrow(() -> new ResourceNotFoundException("Attempt not found: " + attemptId));
        if (!attempt.getUser().getId().equals(user.getId())) {
            throw new BadRequestException("Attempt does not belong to the current user");
        }
        List<QuestionForAttemptResponse> questions = examQuestionRepository.findByExamIdOrderByDisplayOrderAsc(attempt.getExam().getId()).stream()
                .map(ExamQuestion::getQuestion)
                .map(QuestionForAttemptResponse::from)
                .toList();
        return AttemptResponse.from(attempt, questions);
    }

    @Transactional
    public void submitAnswer(Long attemptId, User user, SubmitAnswerRequest request) {
        Attempt attempt = getOwnedInProgressAttempt(attemptId, user);

        ExamQuestion examQuestion = examQuestionRepository.findByExamIdOrderByDisplayOrderAsc(attempt.getExam().getId()).stream()
                .filter(eq -> eq.getQuestion().getId().equals(request.questionId()))
                .findFirst()
                .orElseThrow(() -> new BadRequestException("Question does not belong to this exam: " + request.questionId()));

        Choice selectedChoice = null;
        boolean correct = false;
        if (request.selectedChoiceId() != null) {
            selectedChoice = choiceRepository.findById(request.selectedChoiceId())
                    .orElseThrow(() -> new ResourceNotFoundException("Choice not found: " + request.selectedChoiceId()));
            correct = selectedChoice.isCorrect();
        }

        AttemptAnswer answer = attemptAnswerRepository.findByAttemptAndQuestion(attempt, examQuestion.getQuestion())
                .orElseGet(() -> AttemptAnswer.builder().attempt(attempt).question(examQuestion.getQuestion()).build());
        answer.setSelectedChoice(selectedChoice);
        answer.setCorrect(request.selectedChoiceId() != null ? correct : null);
        attemptAnswerRepository.save(answer);
    }

    @Transactional
    public AttemptResultResponse submitAttempt(Long attemptId, User user) {
        Attempt attempt = getOwnedInProgressAttempt(attemptId, user);

        List<ExamQuestion> examQuestions = examQuestionRepository.findByExamIdOrderByDisplayOrderAsc(attempt.getExam().getId());
        Map<Long, Integer> pointsByQuestionId = examQuestions.stream()
                .collect(Collectors.toMap(eq -> eq.getQuestion().getId(), ExamQuestion::getPoints));

        List<AttemptAnswer> answers = attemptAnswerRepository.findByAttemptId(attemptId);
        Map<Long, AttemptAnswer> answerByQuestionId = answers.stream()
                .collect(Collectors.toMap(a -> a.getQuestion().getId(), Function.identity()));

        int score = answers.stream()
                .filter(a -> Boolean.TRUE.equals(a.getCorrect()))
                .mapToInt(a -> pointsByQuestionId.getOrDefault(a.getQuestion().getId(), 0))
                .sum();

        attempt.setStatus(AttemptStatus.SUBMITTED);
        attempt.setSubmittedAt(Instant.now());
        attempt.setScore(score);
        attemptRepository.save(attempt);

        return buildResult(attempt, examQuestions, answerByQuestionId);
    }

    @Transactional(readOnly = true)
    public AttemptResultResponse getAttemptResult(Long attemptId, User user) {
        Attempt attempt = attemptRepository.findById(attemptId)
                .orElseThrow(() -> new ResourceNotFoundException("Attempt not found: " + attemptId));
        if (!attempt.getUser().getId().equals(user.getId())) {
            throw new BadRequestException("Attempt does not belong to the current user");
        }
        if (attempt.getStatus() != AttemptStatus.SUBMITTED) {
            throw new BadRequestException("Attempt has not been submitted yet: " + attemptId);
        }

        List<ExamQuestion> examQuestions = examQuestionRepository.findByExamIdOrderByDisplayOrderAsc(attempt.getExam().getId());
        Map<Long, AttemptAnswer> answerByQuestionId = attemptAnswerRepository.findByAttemptId(attemptId).stream()
                .collect(Collectors.toMap(a -> a.getQuestion().getId(), Function.identity()));

        return buildResult(attempt, examQuestions, answerByQuestionId);
    }

    private AttemptResultResponse buildResult(Attempt attempt, List<ExamQuestion> examQuestions,
                                               Map<Long, AttemptAnswer> answerByQuestionId) {
        List<AnswerResultResponse> results = examQuestions.stream()
                .sorted(Comparator.comparingInt(ExamQuestion::getDisplayOrder))
                .map(eq -> {
                    Question question = eq.getQuestion();
                    AttemptAnswer answer = answerByQuestionId.get(question.getId());
                    Long correctChoiceId = question.getChoices().stream()
                            .filter(Choice::isCorrect)
                            .map(Choice::getId)
                            .findFirst()
                            .orElse(null);
                    return new AnswerResultResponse(
                            question.getId(),
                            question.getQuestionText(),
                            answer != null && answer.getSelectedChoice() != null ? answer.getSelectedChoice().getId() : null,
                            correctChoiceId,
                            answer != null && Boolean.TRUE.equals(answer.getCorrect()),
                            question.getExplanation());
                })
                .toList();

        return new AttemptResultResponse(attempt.getId(), attempt.getExam().getId(), attempt.getScore(),
                attempt.getMaxScore(), attempt.getSubmittedAt(), results);
    }

    @Transactional(readOnly = true)
    public List<AttemptResponse> getUserAttempts(User user) {
        return attemptRepository.findByUserIdOrderByStartedAtDesc(user.getId()).stream()
                .map(attempt -> AttemptResponse.from(attempt, List.of()))
                .toList();
    }

    private Exam getExamOrThrow(Long examId) {
        return examRepository.findById(examId)
                .orElseThrow(() -> new ResourceNotFoundException("Exam not found: " + examId));
    }

    private Attempt getOwnedInProgressAttempt(Long attemptId, User user) {
        Attempt attempt = attemptRepository.findById(attemptId)
                .orElseThrow(() -> new ResourceNotFoundException("Attempt not found: " + attemptId));
        if (!attempt.getUser().getId().equals(user.getId())) {
            throw new BadRequestException("Attempt does not belong to the current user");
        }
        if (attempt.getStatus() != AttemptStatus.IN_PROGRESS) {
            throw new BadRequestException("Attempt is already submitted: " + attemptId);
        }
        return attempt;
    }
}
