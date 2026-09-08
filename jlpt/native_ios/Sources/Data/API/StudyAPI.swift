import Foundation

final class StudyAPI {
    private let client: APIClient
    init(client: APIClient) { self.client = client }

    func getVocabulary(level: String, page: Int, size: Int) async throws -> [VocabularyStudyResponseDTO] {
        try await client.send(Endpoint(path: "api/study/vocabulary", query: pageQuery(level: level, page: page, size: size)))
    }

    func getKanji(level: String, page: Int, size: Int) async throws -> [KanjiStudyResponseDTO] {
        try await client.send(Endpoint(path: "api/study/kanji", query: pageQuery(level: level, page: page, size: size)))
    }

    func getGrammar(level: String, page: Int, size: Int) async throws -> [GrammarStudyResponseDTO] {
        try await client.send(Endpoint(path: "api/study/grammar", query: pageQuery(level: level, page: page, size: size)))
    }

    func getVocabularyDue(level: String, page: Int, size: Int) async throws -> [VocabularyStudyResponseDTO] {
        try await client.send(Endpoint(path: "api/study/vocabulary/due", query: pageQuery(level: level, page: page, size: size)))
    }

    func getKanjiDue(level: String, page: Int, size: Int) async throws -> [KanjiStudyResponseDTO] {
        try await client.send(Endpoint(path: "api/study/kanji/due", query: pageQuery(level: level, page: page, size: size)))
    }

    func getGrammarDue(level: String, page: Int, size: Int) async throws -> [GrammarStudyResponseDTO] {
        try await client.send(Endpoint(path: "api/study/grammar/due", query: pageQuery(level: level, page: page, size: size)))
    }

    func updateProgress(_ request: UpdateProgressRequestDTO) async throws {
        try await client.sendNoContent(Endpoint(
            path: "api/study/progress",
            method: .post,
            body: Endpoint.withJSONBody(request, encoder: client.encoder)
        ))
    }

    func review(_ request: ReviewRequestDTO) async throws -> ReviewResultResponseDTO {
        try await client.send(Endpoint(
            path: "api/study/review",
            method: .post,
            body: Endpoint.withJSONBody(request, encoder: client.encoder)
        ))
    }

    func getProgressSummary() async throws -> ProgressSummaryResponseDTO {
        try await client.send(Endpoint(path: "api/users/me/progress"))
    }

    private func pageQuery(level: String, page: Int, size: Int) -> [URLQueryItem] {
        [
            URLQueryItem(name: "level", value: level),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "size", value: String(size))
        ]
    }
}
