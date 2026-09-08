import Foundation

@MainActor
final class ExamListViewModel: ObservableObject {
    @Published var level: JlptLevel = .n5 { didSet { load() } }
    @Published var skill: SkillType? = nil { didSet { load() } }
    @Published var showHistory = false { didSet { showHistory ? loadHistory() : load() } }
    @Published private(set) var exams: [ExamSummary] = []
    @Published private(set) var history: [Attempt] = []
    @Published private(set) var isLoading = true
    @Published private(set) var isStarting = false
    @Published var error: String?

    private let listExamsUseCase: ListExamsUseCase
    private let startAttemptUseCase: StartAttemptUseCase
    private let getAttemptHistory: GetAttemptHistoryUseCase

    init(container: AppContainer) {
        listExamsUseCase = container.listExams
        startAttemptUseCase = container.startAttempt
        getAttemptHistory = container.getAttemptHistory
        load()
    }

    func load() {
        Task {
            isLoading = true
            error = nil
            let result = await listExamsUseCase(level: level, skill: skill)
            isLoading = false
            switch result {
            case .success(let items): exams = items
            case .failure(let message, _): error = message
            }
        }
    }

    func loadHistory() {
        Task {
            isLoading = true
            error = nil
            let result = await getAttemptHistory()
            isLoading = false
            switch result {
            case .success(let items): history = items
            case .failure(let message, _): error = message
            }
        }
    }

    func startAttempt(examId: Int64, onStarted: @escaping (Int64) -> Void) {
        Task {
            isStarting = true
            error = nil
            let result = await startAttemptUseCase(examId: examId)
            isStarting = false
            switch result {
            case .success(let attempt): onStarted(attempt.id)
            case .failure(let message, _): error = message
            }
        }
    }
}
