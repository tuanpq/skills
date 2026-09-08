import Foundation

struct LoginRequestDTO: Encodable {
    let email: String
    let password: String
}

struct RegisterRequestDTO: Encodable {
    let email: String
    let password: String
    let displayName: String
    let targetLevel: JlptLevel?
}

struct RefreshRequestDTO: Encodable {
    let refreshToken: String
}

struct AuthResponseDTO: Decodable {
    let accessToken: String
    let refreshToken: String
    let userId: Int64
    let email: String
    let displayName: String
    let role: String
}
