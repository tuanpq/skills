import Foundation

struct GetVocabularyStudyUseCase {
    let repository: StudyRepository
    func callAsFunction(level: JlptLevel, dueOnly: Bool) async -> AppResult<[StudyItem<Vocabulary>]> {
        await repository.getVocabularyProgress(level: level, dueOnly: dueOnly)
    }
}

struct GetKanjiStudyUseCase {
    let repository: StudyRepository
    func callAsFunction(level: JlptLevel, dueOnly: Bool) async -> AppResult<[StudyItem<Kanji>]> {
        await repository.getKanjiProgress(level: level, dueOnly: dueOnly)
    }
}

struct GetGrammarStudyUseCase {
    let repository: StudyRepository
    func callAsFunction(level: JlptLevel, dueOnly: Bool) async -> AppResult<[StudyItem<Grammar>]> {
        await repository.getGrammarProgress(level: level, dueOnly: dueOnly)
    }
}

struct UpdateStudyProgressUseCase {
    let repository: StudyRepository
    func callAsFunction(itemType: StudyItemType, itemId: Int64, status: StudyStatus) async -> AppResult<Void> {
        await repository.updateProgress(itemType: itemType, itemId: itemId, status: status)
    }
}

struct SubmitReviewUseCase {
    let repository: StudyRepository
    func callAsFunction(itemType: StudyItemType, itemId: Int64, quality: Int) async -> AppResult<ReviewResult> {
        await repository.submitReview(itemType: itemType, itemId: itemId, quality: quality)
    }
}

struct GetProgressSummaryUseCase {
    let repository: StudyRepository
    func callAsFunction() async -> AppResult<ProgressSummary> { await repository.getProgressSummary() }
}
