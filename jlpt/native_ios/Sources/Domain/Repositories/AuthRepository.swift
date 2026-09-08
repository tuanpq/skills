import Foundation

protocol AuthRepository {
    /// Broadcasts the currently persisted session, or nil when signed out. Yields once immediately
    /// with the restored-on-launch value, then again on every sign-in/sign-out transition.
    func sessionUpdates() -> AsyncStream<AuthSession?>

    func login(email: String, password: String) async -> AppResult<AuthSession>

    func register(
        email: String,
        password: String,
        displayName: String,
        targetLevel: JlptLevel?
    ) async -> AppResult<AuthSession>

    func logout() async
}
