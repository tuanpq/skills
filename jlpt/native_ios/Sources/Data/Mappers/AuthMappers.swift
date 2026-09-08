import Foundation

extension AuthResponseDTO {
    func toDomain() -> AuthSession {
        AuthSession(
            accessToken: accessToken,
            refreshToken: refreshToken,
            userId: userId,
            email: email,
            displayName: displayName,
            role: UserRole(rawValue: role) ?? .user
        )
    }
}
