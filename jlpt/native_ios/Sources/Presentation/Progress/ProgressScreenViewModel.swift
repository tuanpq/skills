import Foundation

@MainActor
final class ProgressScreenViewModel: ObservableObject {
    @Published private(set) var summary: ProgressSummary?
    @Published private(set) var isLoading = true
    @Published var error: String?

    private let getProgressSummary: GetProgressSummaryUseCase
    private let logoutUseCase: LogoutUseCase

    init(container: AppContainer) {
        getProgressSummary = container.getProgressSummary
        logoutUseCase = container.logout
        Task { await load() }
    }

    func load() async {
        isLoading = true
        error = nil
        let result = await getProgressSummary()
        isLoading = false
        switch result {
        case .success(let value): summary = value
        case .failure(let message, _): error = message
        }
    }

    func logout() async {
        await logoutUseCase()
    }
}
