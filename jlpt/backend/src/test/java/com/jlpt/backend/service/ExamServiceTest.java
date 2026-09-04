package com.jlpt.backend.service;

import com.jlpt.backend.dto.exam.AttemptResultResponse;
import com.jlpt.backend.dto.exam.SubmitAnswerRequest;
import com.jlpt.backend.entity.*;
import com.jlpt.backend.repository.*;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ExamServiceTest {

    @Mock private ExamRepository examRepository;
    @Mock private ExamQuestionRepository examQuestionRepository;
    @Mock private AttemptRepository attemptRepository;
    @Mock private AttemptAnswerRepository attemptAnswerRepository;
    @Mock private ChoiceRepository choiceRepository;

    @InjectMocks
    private ExamService examService;

    private User user;
    private Exam exam;
    private Question question1;
    private Question question2;
    private Choice correctChoice1;
    private Choice wrongChoice1;
    private Choice correctChoice2;

    @BeforeEach
    void setUp() {
        user = User.builder().id(1L).email("test@example.com").displayName("Test").role(UserRole.USER).build();
        exam = Exam.builder().id(10L).level(JlptLevel.N5).title("Sample").examType(ExamType.FULL_MOCK).timeLimitMinutes(20).build();

        question1 = Question.builder().id(100L).level(JlptLevel.N5).skillType(SkillType.VOCABULARY).questionText("Q1").build();
        correctChoice1 = Choice.builder().id(1000L).question(question1).choiceText("correct").correct(true).displayOrder(1).build();
        wrongChoice1 = Choice.builder().id(1001L).question(question1).choiceText("wrong").correct(false).displayOrder(2).build();
        question1.setChoices(List.of(correctChoice1, wrongChoice1));

        question2 = Question.builder().id(101L).level(JlptLevel.N5).skillType(SkillType.GRAMMAR).questionText("Q2").build();
        correctChoice2 = Choice.builder().id(1002L).question(question2).choiceText("correct2").correct(true).displayOrder(1).build();
        question2.setChoices(List.of(correctChoice2));
    }

    @Test
    void startAttempt_computesMaxScoreFromExamQuestions() {
        ExamQuestion eq1 = ExamQuestion.builder().id(1L).exam(exam).question(question1).displayOrder(1).points(2).build();
        ExamQuestion eq2 = ExamQuestion.builder().id(2L).exam(exam).question(question2).displayOrder(2).points(3).build();

        when(examRepository.findById(10L)).thenReturn(Optional.of(exam));
        when(examQuestionRepository.findByExamIdOrderByDisplayOrderAsc(10L)).thenReturn(List.of(eq1, eq2));
        when(attemptRepository.save(any(Attempt.class))).thenAnswer(inv -> inv.getArgument(0));

        var response = examService.startAttempt(10L, user);

        assertThat(response.maxScore()).isEqualTo(5);
        assertThat(response.questions()).hasSize(2);
    }

    @Test
    void submitAttempt_scoresOnlyCorrectAnswers() {
        ExamQuestion eq1 = ExamQuestion.builder().id(1L).exam(exam).question(question1).displayOrder(1).points(2).build();
        ExamQuestion eq2 = ExamQuestion.builder().id(2L).exam(exam).question(question2).displayOrder(2).points(3).build();

        Attempt attempt = Attempt.builder().id(500L).user(user).exam(exam).status(AttemptStatus.IN_PROGRESS).maxScore(5).build();

        AttemptAnswer answer1 = AttemptAnswer.builder().id(1L).attempt(attempt).question(question1).selectedChoice(correctChoice1).correct(true).build();
        AttemptAnswer answer2 = AttemptAnswer.builder().id(2L).attempt(attempt).question(question2).selectedChoice(null).correct(null).build();

        when(attemptRepository.findById(500L)).thenReturn(Optional.of(attempt));
        when(examQuestionRepository.findByExamIdOrderByDisplayOrderAsc(10L)).thenReturn(List.of(eq1, eq2));
        when(attemptAnswerRepository.findByAttemptId(500L)).thenReturn(List.of(answer1, answer2));
        when(attemptRepository.save(any(Attempt.class))).thenAnswer(inv -> inv.getArgument(0));

        AttemptResultResponse result = examService.submitAttempt(500L, user);

        assertThat(result.score()).isEqualTo(2);
        assertThat(result.maxScore()).isEqualTo(5);
        assertThat(attempt.getStatus()).isEqualTo(AttemptStatus.SUBMITTED);
    }

    @Test
    void submitAnswer_marksCorrectWhenChoiceMatches() {
        ExamQuestion eq1 = ExamQuestion.builder().id(1L).exam(exam).question(question1).displayOrder(1).points(1).build();
        Attempt attempt = Attempt.builder().id(500L).user(user).exam(exam).status(AttemptStatus.IN_PROGRESS).build();

        when(attemptRepository.findById(500L)).thenReturn(Optional.of(attempt));
        when(examQuestionRepository.findByExamIdOrderByDisplayOrderAsc(10L)).thenReturn(List.of(eq1));
        when(choiceRepository.findById(1000L)).thenReturn(Optional.of(correctChoice1));
        when(attemptAnswerRepository.findByAttemptAndQuestion(attempt, question1)).thenReturn(Optional.empty());
        when(attemptAnswerRepository.save(any(AttemptAnswer.class))).thenAnswer(inv -> inv.getArgument(0));

        examService.submitAnswer(500L, user, new SubmitAnswerRequest(100L, 1000L));
    }
}
