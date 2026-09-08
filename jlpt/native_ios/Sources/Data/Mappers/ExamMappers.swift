import Foundation

extension ChoiceOptionResponseDTO {
    func toDomain() -> ChoiceOption { ChoiceOption(id: id, choiceText: choiceText, displayOrder: displayOrder) }
}

extension QuestionForAttemptResponseDTO {
    func toDomain() -> ExamQuestion {
        ExamQuestion(
            id: id, skillType: skillType, questionText: questionText, passageContent: passageContent,
            listeningAudioId: listeningAudioId, choices: choices.map { $0.toDomain() }
        )
    }
}

extension ExamSummaryResponseDTO {
    func toDomain() -> ExamSummary {
        ExamSummary(
            id: id, level: level, title: title, examType: examType, skillType: skillType,
            timeLimitMinutes: timeLimitMinutes, questionCount: questionCount
        )
    }
}

extension ExamDetailResponseDTO {
    func toDomain() -> ExamDetail {
        ExamDetail(
            id: id, level: level, title: title, examType: examType, skillType: skillType,
            timeLimitMinutes: timeLimitMinutes, questions: questions.map { $0.toDomain() }
        )
    }
}

extension AttemptResponseDTO {
    func toDomain() -> Attempt {
        Attempt(
            id: id, examId: examId, examTitle: examTitle, status: status,
            startedAt: ISO8601.parseOrEpoch(startedAt), submittedAt: ISO8601.parse(submittedAt),
            score: score, maxScore: maxScore, questions: questions.map { $0.toDomain() }
        )
    }
}

extension AnswerResultResponseDTO {
    func toDomain() -> AnswerResult {
        AnswerResult(
            questionId: questionId, questionText: questionText, selectedChoiceId: selectedChoiceId,
            correctChoiceId: correctChoiceId, correct: correct, explanation: explanation
        )
    }
}

extension AttemptResultResponseDTO {
    func toDomain() -> AttemptResult {
        AttemptResult(
            attemptId: attemptId, examId: examId, score: score, maxScore: maxScore,
            submittedAt: ISO8601.parse(submittedAt), answers: answers.map { $0.toDomain() }
        )
    }
}
