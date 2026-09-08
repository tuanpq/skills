import Foundation

final class ExamAPI {
    private let client: APIClient
    init(client: APIClient) { self.client = client }

    func listExams(level: String, skill: String?) async throws -> [ExamSummaryResponseDTO] {
        var query = [URLQueryItem(name: "level", value: level)]
        if let skill { query.append(URLQueryItem(name: "skill", value: skill)) }
        return try await client.send(Endpoint(path: "api/exams", query: query))
    }

    func getExam(id: Int64) async throws -> ExamDetailResponseDTO {
        try await client.send(Endpoint(path: "api/exams/\(id)"))
    }

    func startAttempt(examId: Int64) async throws -> AttemptResponseDTO {
        try await client.send(Endpoint(path: "api/exams/\(examId)/attempts", method: .post))
    }

    func getAttempt(id: Int64) async throws -> AttemptResponseDTO {
        try await client.send(Endpoint(path: "api/attempts/\(id)"))
    }

    func submitAnswer(attemptId: Int64, request: SubmitAnswerRequestDTO) async throws {
        try await client.sendNoContent(Endpoint(
            path: "api/attempts/\(attemptId)/answers",
            method: .put,
            body: Endpoint.withJSONBody(request, encoder: client.encoder)
        ))
    }

    func submitAttempt(attemptId: Int64) async throws -> AttemptResultResponseDTO {
        try await client.send(Endpoint(path: "api/attempts/\(attemptId)/submit", method: .post))
    }

    func getAttemptResult(attemptId: Int64) async throws -> AttemptResultResponseDTO {
        try await client.send(Endpoint(path: "api/attempts/\(attemptId)/result"))
    }

    func getMyAttempts() async throws -> [AttemptResponseDTO] {
        try await client.send(Endpoint(path: "api/users/me/attempts"))
    }
}
