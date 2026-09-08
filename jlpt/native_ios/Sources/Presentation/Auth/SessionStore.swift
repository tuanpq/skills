import Foundation

/// App-wide session holder: drives which root view (auth vs. main) is shown, and reacts when
/// `TokenStore` clears the session after a failed refresh.
@MainActor
final class SessionStore: ObservableObject {
    enum State: Equatable {
        case loading
        case signedIn(AuthSession)
        case signedOut
    }

    @Published private(set) var state: State = .loading

    private let observeSession: ObserveSessionUseCase
    private let logoutUseCase: LogoutUseCase
    private var observationTask: Task<Void, Never>?

    init(container: AppContainer) {
        observeSession = container.observeSession
        logoutUseCase = container.logout
        observationTask = Task { [weak self] in
            guard let self else { return }
            for await session in observeSession() {
                self.state = session != nil ? .signedIn(session!) : .signedOut
            }
        }
    }

    func logout() async {
        await logoutUseCase()
    }

    deinit {
        observationTask?.cancel()
    }
}
