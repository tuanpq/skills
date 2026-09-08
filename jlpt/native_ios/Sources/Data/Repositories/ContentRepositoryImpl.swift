import Foundation

/// Each JLPT level's content set is small (see backend seed data), so one page fits it all.
private let pageSize = 200

final class ContentRepositoryImpl: ContentRepository {
    private let api: ContentAPI
    init(api: ContentAPI) { self.api = api }

    func getVocabulary(level: JlptLevel) async -> AppResult<[Vocabulary]> {
        await safeCall { try await self.api.getVocabulary(level: level.rawValue, page: 0, size: pageSize).content.map { $0.toDomain() } }
    }

    func getKanji(level: JlptLevel) async -> AppResult<[Kanji]> {
        await safeCall { try await self.api.getKanji(level: level.rawValue, page: 0, size: pageSize).content.map { $0.toDomain() } }
    }

    func getGrammar(level: JlptLevel) async -> AppResult<[Grammar]> {
        await safeCall { try await self.api.getGrammar(level: level.rawValue, page: 0, size: pageSize).content.map { $0.toDomain() } }
    }

    func getPassage(id: Int64) async -> AppResult<Passage> {
        await safeCall { try await self.api.getPassage(id: id).toDomain() }
    }

    func getListeningAudio(id: Int64) async -> AppResult<ListeningAudio> {
        await safeCall { try await self.api.getListeningAudio(id: id).toDomain() }
    }
}
