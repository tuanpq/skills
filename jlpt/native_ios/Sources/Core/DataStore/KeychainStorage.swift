import Foundation
import Security

/// Persists the JWT session (access + refresh token, user profile) in the Keychain so the app can
/// restore the signed-in state on cold start, mirroring encrypted DataStore/Keychain usage on the
/// other platforms. Wraps the synchronous Security framework calls, which are safe to call from
/// any thread/actor.
enum KeychainStorage {
    private static let service = "com.jlpt.ios.session"
    private static let account = "current-session"

    /// Local persistence shape; kept separate from the domain `AuthSession` so the domain layer
    /// has no dependency on `Codable`/Foundation serialization concerns.
    private struct PersistedSession: Codable {
        let accessToken: String
        let refreshToken: String
        let userId: Int64
        let email: String
        let displayName: String
        let role: String
    }

    static func loadSession() -> AuthSession? {
        guard let data = load(), let persisted = try? JSONDecoder().decode(PersistedSession.self, from: data) else {
            return nil
        }
        return AuthSession(
            accessToken: persisted.accessToken,
            refreshToken: persisted.refreshToken,
            userId: persisted.userId,
            email: persisted.email,
            displayName: persisted.displayName,
            role: UserRole(rawValue: persisted.role) ?? .user
        )
    }

    static func save(_ session: AuthSession) {
        let persisted = PersistedSession(
            accessToken: session.accessToken,
            refreshToken: session.refreshToken,
            userId: session.userId,
            email: session.email,
            displayName: session.displayName,
            role: session.role.rawValue
        )
        guard let data = try? JSONEncoder().encode(persisted) else { return }
        save(data)
    }

    static func clear() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)
    }

    private static func load() -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        guard status == errSecSuccess else { return nil }
        return result as? Data
    }

    private static func save(_ data: Data) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        let attributes: [String: Any] = [kSecValueData as String: data]

        let status = SecItemCopyMatching(query as CFDictionary, nil)
        if status == errSecSuccess {
            SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        } else {
            var newItem = query
            newItem[kSecValueData as String] = data
            newItem[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlock
            SecItemAdd(newItem as CFDictionary, nil)
        }
    }
}
