import Foundation

@MainActor
final class ReviewViewModel: ObservableObject {
    let itemType: StudyItemType
    @Published var level: JlptLevel = .n5 { didSet { load() } }
    @Published private(set) var vocabQueue: [StudyItem<Vocabulary>] = []
    @Published private(set) var kanjiQueue: [StudyItem<Kanji>] = []
    @Published private(set) var grammarQueue: [StudyItem<Grammar>] = []
    @Published var isFlipped = false
    @Published private(set) var isLoading = true
    @Published var error: String?
    @Published private(set) var finished = false

    private let getVocabularyStudy: GetVocabularyStudyUseCase
    private let getKanjiStudy: GetKanjiStudyUseCase
    private let getGrammarStudy: GetGrammarStudyUseCase
    private let submitReviewUseCase: SubmitReviewUseCase

    var remaining: Int {
        switch itemType {
        case .vocabulary: return vocabQueue.count
        case .kanji: return kanjiQueue.count
        case .grammar: return grammarQueue.count
        }
    }

    init(container: AppContainer, itemType: StudyItemType) {
        self.itemType = itemType
        getVocabularyStudy = container.getVocabularyStudy
        getKanjiStudy = container.getKanjiStudy
        getGrammarStudy = container.getGrammarStudy
        submitReviewUseCase = container.submitReview
        load()
    }

    func load() {
        Task {
            isLoading = true
            error = nil
            switch itemType {
            case .vocabulary:
                let result = await getVocabularyStudy(level: level, dueOnly: true)
                isLoading = false
                switch result {
                case .success(let items):
                    vocabQueue = items
                    finished = items.isEmpty
                case .failure(let message, _): error = message
                }
            case .kanji:
                let result = await getKanjiStudy(level: level, dueOnly: true)
                isLoading = false
                switch result {
                case .success(let items):
                    kanjiQueue = items
                    finished = items.isEmpty
                case .failure(let message, _): error = message
                }
            case .grammar:
                let result = await getGrammarStudy(level: level, dueOnly: true)
                isLoading = false
                switch result {
                case .success(let items):
                    grammarQueue = items
                    finished = items.isEmpty
                case .failure(let message, _): error = message
                }
            }
        }
    }

    func flip() { isFlipped.toggle() }

    /// Rates recall quality for the head of the due queue, then advances (SM-2 scheduling on the backend).
    func rate(_ quality: ReviewQuality) {
        let itemId: Int64?
        switch itemType {
        case .vocabulary: itemId = vocabQueue.first?.item.id
        case .kanji: itemId = kanjiQueue.first?.item.id
        case .grammar: itemId = grammarQueue.first?.item.id
        }
        guard let itemId else { return }

        Task {
            let result = await submitReviewUseCase(itemType: itemType, itemId: itemId, quality: quality.rawValue)
            guard case .success = result else { return }
            switch itemType {
            case .vocabulary: if !vocabQueue.isEmpty { vocabQueue.removeFirst() }
            case .kanji: if !kanjiQueue.isEmpty { kanjiQueue.removeFirst() }
            case .grammar: if !grammarQueue.isEmpty { grammarQueue.removeFirst() }
            }
            isFlipped = false
            finished = remaining == 0
        }
    }
}
