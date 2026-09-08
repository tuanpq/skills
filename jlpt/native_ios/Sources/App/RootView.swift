import SwiftUI

/// Root of the navigation tree: shows Login/Register while signed out, or the tab-based `HomeShell`
/// once signed in, automatically switching the moment `SessionStore` reports a change (login,
/// register, logout, or a failed silent token refresh) — no manual "navigate home" calls needed.
struct RootView: View {
    let container: AppContainer
    @StateObject private var sessionStore: SessionStore
    @State private var path = NavigationPath()
    @State private var showRegister = false

    init(container: AppContainer) {
        self.container = container
        _sessionStore = StateObject(wrappedValue: SessionStore(container: container))
    }

    var body: some View {
        Group {
            switch sessionStore.state {
            case .loading:
                LoadingView()
            case .signedOut:
                NavigationStack {
                    if showRegister {
                        RegisterView(
                            container: container,
                            onRegisterSuccess: {},
                            onNavigateToLogin: { showRegister = false }
                        )
                    } else {
                        LoginView(
                            container: container,
                            onLoginSuccess: {},
                            onNavigateToRegister: { showRegister = true }
                        )
                    }
                }
            case .signedIn:
                NavigationStack(path: $path) {
                    HomeShellView(container: container, push: { path.append($0) })
                        .navigationDestination(for: AppRoute.self) { route in
                            destination(for: route)
                        }
                }
            }
        }
    }

    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
        switch route {
        case .review(let itemType):
            ReviewView(container: container, itemType: itemType)
        case .examAttempt(let attemptId):
            ExamAttemptView(container: container, attemptId: attemptId) { resultAttemptId in
                if !path.isEmpty { path.removeLast() }
                path.append(AppRoute.attemptResult(attemptId: resultAttemptId))
            }
        case .attemptResult(let attemptId):
            AttemptResultView(container: container, attemptId: attemptId)
        }
    }
}
