import Foundation

@MainActor
final class StudyViewModel: ObservableObject {
    @Published var level: JlptLevel = .n5 { didSet { resetAndLoad() } }
    @Published var type: StudyItemType = .vocabulary { didSet { resetAndLoad() } }
    @Published private(set) var vocabItems: [StudyItem<Vocabulary>] = []
    @Published private(set) var kanjiItems: [StudyItem<Kanji>] = []
    @Published private(set) var grammarItems: [StudyItem<Grammar>] = []
    @Published var currentIndex: Int = 0
    @Published var isFlipped = false
    @Published private(set) var isLoading = false
    @Published var error: String?

    private let getVocabularyStudy: GetVocabularyStudyUseCase
    private let getKanjiStudy: GetKanjiStudyUseCase
    private let getGrammarStudy: GetGrammarStudyUseCase
    private let updateStudyProgress: UpdateStudyProgressUseCase

    var currentCount: Int {
        switch type {
        case .vocabulary: return vocabItems.count
        case .kanji: return kanjiItems.count
        case .grammar: return grammarItems.count
        }
    }

    init(container: AppContainer) {
        getVocabularyStudy = container.getVocabularyStudy
        getKanjiStudy = container.getKanjiStudy
        getGrammarStudy = container.getGrammarStudy
        updateStudyProgress = container.updateStudyProgress
        Task { await load() }
    }

    private func resetAndLoad() {
        currentIndex = 0
        isFlipped = false
        Task { await load() }
    }

    func flip() { isFlipped.toggle() }

    func next() {
        guard currentCount > 0 else { return }
        currentIndex = (currentIndex + 1) % currentCount
        isFlipped = false
    }

    func previous() {
        guard currentCount > 0 else { return }
        currentIndex = currentIndex == 0 ? currentCount - 1 : currentIndex - 1
        isFlipped = false
    }

    func load() async {
        isLoading = true
        error = nil
        switch type {
        case .vocabulary:
            let result = await getVocabularyStudy(level: level, dueOnly: false)
            isLoading = false
            switch result {
            case .success(let items): vocabItems = items
            case .failure(let message, _): error = message
            }
        case .kanji:
            let result = await getKanjiStudy(level: level, dueOnly: false)
            isLoading = false
            switch result {
            case .success(let items): kanjiItems = items
            case .failure(let message, _): error = message
            }
        case .grammar:
            let result = await getGrammarStudy(level: level, dueOnly: false)
            isLoading = false
            switch result {
            case .success(let items): grammarItems = items
            case .failure(let message, _): error = message
            }
        }
    }

    /// Manually sets NEW/LEARNING/MASTERED for the currently shown card, independent of SRS review.
    func markStatus(_ status: StudyStatus) {
        let itemId: Int64?
        switch type {
        case .vocabulary: itemId = vocabItems[safe: currentIndex]?.item.id
        case .kanji: itemId = kanjiItems[safe: currentIndex]?.item.id
        case .grammar: itemId = grammarItems[safe: currentIndex]?.item.id
        }
        guard let itemId else { return }

        Task {
            let result = await updateStudyProgress(itemType: type, itemId: itemId, status: status)
            guard case .success = result else { return }
            let index = currentIndex
            switch type {
            case .vocabulary:
                if vocabItems.indices.contains(index) { vocabItems[index].status = status }
            case .kanji:
                if kanjiItems.indices.contains(index) { kanjiItems[index].status = status }
            case .grammar:
                if grammarItems.indices.contains(index) { grammarItems[index].status = status }
            }
            next()
        }
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
