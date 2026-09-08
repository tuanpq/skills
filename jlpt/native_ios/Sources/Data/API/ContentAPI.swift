import Foundation

final class ContentAPI {
    private let client: APIClient
    init(client: APIClient) { self.client = client }

    func getVocabulary(level: String, page: Int, size: Int) async throws -> PageDTO<VocabularyResponseDTO> {
        try await client.send(Endpoint(path: "api/vocabulary", query: pageQuery(level: level, page: page, size: size)))
    }

    func getKanji(level: String, page: Int, size: Int) async throws -> PageDTO<KanjiResponseDTO> {
        try await client.send(Endpoint(path: "api/kanji", query: pageQuery(level: level, page: page, size: size)))
    }

    func getGrammar(level: String, page: Int, size: Int) async throws -> PageDTO<GrammarResponseDTO> {
        try await client.send(Endpoint(path: "api/grammar", query: pageQuery(level: level, page: page, size: size)))
    }

    func getPassage(id: Int64) async throws -> PassageResponseDTO {
        try await client.send(Endpoint(path: "api/passages/\(id)"))
    }

    func getListeningAudio(id: Int64) async throws -> ListeningAudioResponseDTO {
        try await client.send(Endpoint(path: "api/listening-audios/\(id)"))
    }

    private func pageQuery(level: String, page: Int, size: Int) -> [URLQueryItem] {
        [
            URLQueryItem(name: "level", value: level),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "size", value: String(size))
        ]
    }
}
