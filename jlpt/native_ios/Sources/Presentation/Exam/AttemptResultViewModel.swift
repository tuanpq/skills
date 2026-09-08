import Foundation

@MainActor
final class AttemptResultViewModel: ObservableObject {
    let attemptId: Int64
    @Published private(set) var result: AttemptResult?
    @Published private(set) var isLoading = true
    @Published var error: String?

    private let getAttemptResultUseCase: GetAttemptResultUseCase

    init(container: AppContainer, attemptId: Int64) {
        self.attemptId = attemptId
        getAttemptResultUseCase = container.getAttemptResult
        Task { await load() }
    }

    func load() async {
        isLoading = true
        error = nil
        let outcome = await getAttemptResultUseCase(attemptId: attemptId)
        isLoading = false
        switch outcome {
        case .success(let value): result = value
        case .failure(let message, _): error = message
        }
    }
}
