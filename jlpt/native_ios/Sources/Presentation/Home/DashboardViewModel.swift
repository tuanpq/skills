import Foundation

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published private(set) var session: AuthSession?
    @Published private(set) var progress: ProgressSummary?
    @Published private(set) var isLoading = true
    @Published var error: String?

    private let observeSession: ObserveSessionUseCase
    private let getProgressSummary: GetProgressSummaryUseCase
    private var observationTask: Task<Void, Never>?

    init(container: AppContainer) {
        observeSession = container.observeSession
        getProgressSummary = container.getProgressSummary
        observationTask = Task { [weak self] in
            guard let self else { return }
            for await session in observeSession() {
                self.session = session
            }
        }
        Task { await load() }
    }

    func load() async {
        isLoading = true
        error = nil
        let result = await getProgressSummary()
        isLoading = false
        switch result {
        case .success(let summary): progress = summary
        case .failure(let message, _): error = message
        }
    }

    deinit {
        observationTask?.cancel()
    }
}
