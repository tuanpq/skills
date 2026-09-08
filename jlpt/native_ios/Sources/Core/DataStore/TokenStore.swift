import Foundation

/// Single source of truth for the signed-in session. An `actor` so concurrent requests hitting a
/// 401 at the same time dedupe onto one in-flight refresh call instead of each firing their own
/// (mirrors the frontend's single-flight axios refresh interceptor).
actor TokenStore {
    private(set) var session: AuthSession?
    private var continuations: [UUID: AsyncStream<AuthSession?>.Continuation] = [:]
    private var refreshTask: Task<String?, Never>?

    private let refreshURL: URL
    private let urlSession: URLSession

    init(baseURL: URL = APIConfig.baseURL, urlSession: URLSession = .shared) {
        self.refreshURL = baseURL.appendingPathComponent("api/auth/refresh")
        self.urlSession = urlSession
        self.session = KeychainStorage.loadSession()
    }

    /// Yields the current session immediately, then again on every sign-in/sign-out transition.
    func sessionUpdates() -> AsyncStream<AuthSession?> {
        AsyncStream { continuation in
            let id = UUID()
            continuations[id] = continuation
            continuation.yield(session)
            continuation.onTermination = { [weak self] _ in
                Task { await self?.removeContinuation(id) }
            }
        }
    }

    func save(_ newSession: AuthSession) {
        session = newSession
        KeychainStorage.save(newSession)
        broadcast()
    }

    func clear() {
        session = nil
        KeychainStorage.clear()
        broadcast()
    }

    /// Called by `APIClient` on a 401; returns a fresh access token, or nil if the refresh token
    /// itself is invalid/expired (in which case the session has already been cleared).
    func refreshedAccessToken() async -> String? {
        if let inFlight = refreshTask {
            return await inFlight.value
        }
        guard let refreshToken = session?.refreshToken else { return nil }

        let task = Task<String?, Never> { [refreshURL, urlSession] in
            do {
                var request = URLRequest(url: refreshURL)
                request.httpMethod = HTTPMethod.post.rawValue
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try JSONEncoder().encode(RefreshRequestDTO(refreshToken: refreshToken))

                let (data, response) = try await urlSession.data(for: request)
                guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
                    await self.clear()
                    return nil
                }
                let dto = try JSONDecoder().decode(AuthResponseDTO.self, from: data)
                let updated = AuthSession(
                    accessToken: dto.accessToken,
                    refreshToken: dto.refreshToken,
                    userId: dto.userId,
                    email: dto.email,
                    displayName: dto.displayName,
                    role: UserRole(rawValue: dto.role) ?? .user
                )
                await self.save(updated)
                return dto.accessToken
            } catch {
                await self.clear()
                return nil
            }
        }
        refreshTask = task
        let result = await task.value
        refreshTask = nil
        return result
    }

    private func removeContinuation(_ id: UUID) {
        continuations[id] = nil
    }

    private func broadcast() {
        for (_, continuation) in continuations {
            continuation.yield(session)
        }
    }
}
