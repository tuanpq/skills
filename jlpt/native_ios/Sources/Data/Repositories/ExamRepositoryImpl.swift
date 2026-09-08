import Foundation

final class ExamRepositoryImpl: ExamRepository {
    private let api: ExamAPI
    init(api: ExamAPI) { self.api = api }

    func listExams(level: JlptLevel, skill: SkillType?) async -> AppResult<[ExamSummary]> {
        await safeCall { try await self.api.listExams(level: level.rawValue, skill: skill?.rawValue).map { $0.toDomain() } }
    }

    func getExam(id: Int64) async -> AppResult<ExamDetail> {
        await safeCall { try await self.api.getExam(id: id).toDomain() }
    }

    func startAttempt(examId: Int64) async -> AppResult<Attempt> {
        await safeCall { try await self.api.startAttempt(examId: examId).toDomain() }
    }

    func getAttempt(id: Int64) async -> AppResult<Attempt> {
        await safeCall { try await self.api.getAttempt(id: id).toDomain() }
    }

    func submitAnswer(attemptId: Int64, questionId: Int64, selectedChoiceId: Int64?) async -> AppResult<Void> {
        await safeCall {
            try await self.api.submitAnswer(attemptId: attemptId, request: SubmitAnswerRequestDTO(questionId: questionId, selectedChoiceId: selectedChoiceId))
        }
    }

    func submitAttempt(attemptId: Int64) async -> AppResult<AttemptResult> {
        await safeCall { try await self.api.submitAttempt(attemptId: attemptId).toDomain() }
    }

    func getAttemptResult(attemptId: Int64) async -> AppResult<AttemptResult> {
        await safeCall { try await self.api.getAttemptResult(attemptId: attemptId).toDomain() }
    }

    func getMyAttempts() async -> AppResult<[Attempt]> {
        await safeCall { try await self.api.getMyAttempts().map { $0.toDomain() } }
    }
}
