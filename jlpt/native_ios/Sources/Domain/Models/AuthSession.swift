import Foundation

struct AuthSession: Equatable {
    let accessToken: String
    let refreshToken: String
    let userId: Int64
    let email: String
    let displayName: String
    let role: UserRole
}
