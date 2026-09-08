import Foundation

final class AuthRepositoryImpl: AuthRepository {
    private let api: AuthAPI
    private let tokenStore: TokenStore

    init(api: AuthAPI, tokenStore: TokenStore) {
        self.api = api
        self.tokenStore = tokenStore
    }

    func sessionUpdates() -> AsyncStream<AuthSession?> {
        tokenStore.sessionUpdates()
    }

    func login(email: String, password: String) async -> AppResult<AuthSession> {
        let result = await safeCall { try await self.api.login(LoginRequestDTO(email: email, password: password)).toDomain() }
        if case .success(let session) = result {
            await tokenStore.save(session)
        }
        return result
    }

    func register(
        email: String,
        password: String,
        displayName: String,
        targetLevel: JlptLevel?
    ) async -> AppResult<AuthSession> {
        let request = RegisterRequestDTO(email: email, password: password, displayName: displayName, targetLevel: targetLevel)
        let result = await safeCall { try await self.api.register(request).toDomain() }
        if case .success(let session) = result {
            await tokenStore.save(session)
        }
        return result
    }

    func logout() async {
        await tokenStore.clear()
    }
}
