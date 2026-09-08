import Foundation

private let pageSize = 200

final class StudyRepositoryImpl: StudyRepository {
    private let api: StudyAPI
    init(api: StudyAPI) { self.api = api }

    func getVocabularyProgress(level: JlptLevel, dueOnly: Bool) async -> AppResult<[StudyItem<Vocabulary>]> {
        await safeCall {
            let dtos = dueOnly
                ? try await self.api.getVocabularyDue(level: level.rawValue, page: 0, size: pageSize)
                : try await self.api.getVocabulary(level: level.rawValue, page: 0, size: pageSize)
            return dtos.map { $0.toDomain() }
        }
    }

    func getKanjiProgress(level: JlptLevel, dueOnly: Bool) async -> AppResult<[StudyItem<Kanji>]> {
        await safeCall {
            let dtos = dueOnly
                ? try await self.api.getKanjiDue(level: level.rawValue, page: 0, size: pageSize)
                : try await self.api.getKanji(level: level.rawValue, page: 0, size: pageSize)
            return dtos.map { $0.toDomain() }
        }
    }

    func getGrammarProgress(level: JlptLevel, dueOnly: Bool) async -> AppResult<[StudyItem<Grammar>]> {
        await safeCall {
            let dtos = dueOnly
                ? try await self.api.getGrammarDue(level: level.rawValue, page: 0, size: pageSize)
                : try await self.api.getGrammar(level: level.rawValue, page: 0, size: pageSize)
            return dtos.map { $0.toDomain() }
        }
    }

    func updateProgress(itemType: StudyItemType, itemId: Int64, status: StudyStatus) async -> AppResult<Void> {
        await safeCall { try await self.api.updateProgress(UpdateProgressRequestDTO(itemType: itemType, itemId: itemId, status: status)) }
    }

    func submitReview(itemType: StudyItemType, itemId: Int64, quality: Int) async -> AppResult<ReviewResult> {
        await safeCall { try await self.api.review(ReviewRequestDTO(itemType: itemType, itemId: itemId, quality: quality)).toDomain() }
    }

    func getProgressSummary() async -> AppResult<ProgressSummary> {
        await safeCall { try await self.api.getProgressSummary().toDomain() }
    }
}
