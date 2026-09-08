import Foundation

struct ObserveSessionUseCase {
    let repository: AuthRepository
    func callAsFunction() -> AsyncStream<AuthSession?> { repository.sessionUpdates() }
}

struct LoginUseCase {
    let repository: AuthRepository
    func callAsFunction(email: String, password: String) async -> AppResult<AuthSession> {
        await repository.login(email: email, password: password)
    }
}

struct RegisterUseCase {
    let repository: AuthRepository
    func callAsFunction(
        email: String,
        password: String,
        displayName: String,
        targetLevel: JlptLevel?
    ) async -> AppResult<AuthSession> {
        await repository.register(email: email, password: password, displayName: displayName, targetLevel: targetLevel)
    }
}

struct LogoutUseCase {
    let repository: AuthRepository
    func callAsFunction() async { await repository.logout() }
}
