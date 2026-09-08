import Foundation

struct ListExamsUseCase {
    let repository: ExamRepository
    func callAsFunction(level: JlptLevel, skill: SkillType?) async -> AppResult<[ExamSummary]> {
        await repository.listExams(level: level, skill: skill)
    }
}

struct GetExamDetailUseCase {
    let repository: ExamRepository
    func callAsFunction(id: Int64) async -> AppResult<ExamDetail> { await repository.getExam(id: id) }
}

struct StartAttemptUseCase {
    let repository: ExamRepository
    func callAsFunction(examId: Int64) async -> AppResult<Attempt> { await repository.startAttempt(examId: examId) }
}

struct GetAttemptUseCase {
    let repository: ExamRepository
    func callAsFunction(id: Int64) async -> AppResult<Attempt> { await repository.getAttempt(id: id) }
}

struct SubmitAnswerUseCase {
    let repository: ExamRepository
    func callAsFunction(attemptId: Int64, questionId: Int64, selectedChoiceId: Int64?) async -> AppResult<Void> {
        await repository.submitAnswer(attemptId: attemptId, questionId: questionId, selectedChoiceId: selectedChoiceId)
    }
}

struct SubmitAttemptUseCase {
    let repository: ExamRepository
    func callAsFunction(attemptId: Int64) async -> AppResult<AttemptResult> { await repository.submitAttempt(attemptId: attemptId) }
}

struct GetAttemptResultUseCase {
    let repository: ExamRepository
    func callAsFunction(attemptId: Int64) async -> AppResult<AttemptResult> { await repository.getAttemptResult(attemptId: attemptId) }
}

struct GetAttemptHistoryUseCase {
    let repository: ExamRepository
    func callAsFunction() async -> AppResult<[Attempt]> { await repository.getMyAttempts() }
}
