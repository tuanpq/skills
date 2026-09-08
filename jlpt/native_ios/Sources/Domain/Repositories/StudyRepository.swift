import Foundation

protocol StudyRepository {
    func getVocabularyProgress(level: JlptLevel, dueOnly: Bool) async -> AppResult<[StudyItem<Vocabulary>]>
    func getKanjiProgress(level: JlptLevel, dueOnly: Bool) async -> AppResult<[StudyItem<Kanji>]>
    func getGrammarProgress(level: JlptLevel, dueOnly: Bool) async -> AppResult<[StudyItem<Grammar>]>

    func updateProgress(itemType: StudyItemType, itemId: Int64, status: StudyStatus) async -> AppResult<Void>

    /// Submits a spaced-repetition recall score (0-5) for one item and returns its new schedule.
    func submitReview(itemType: StudyItemType, itemId: Int64, quality: Int) async -> AppResult<ReviewResult>

    func getProgressSummary() async -> AppResult<ProgressSummary>
}
