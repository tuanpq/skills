import Foundation

protocol ExamRepository {
    func listExams(level: JlptLevel, skill: SkillType?) async -> AppResult<[ExamSummary]>
    func getExam(id: Int64) async -> AppResult<ExamDetail>
    func startAttempt(examId: Int64) async -> AppResult<Attempt>
    func getAttempt(id: Int64) async -> AppResult<Attempt>
    func submitAnswer(attemptId: Int64, questionId: Int64, selectedChoiceId: Int64?) async -> AppResult<Void>
    func submitAttempt(attemptId: Int64) async -> AppResult<AttemptResult>
    func getAttemptResult(attemptId: Int64) async -> AppResult<AttemptResult>
    func getMyAttempts() async -> AppResult<[Attempt]>
}
