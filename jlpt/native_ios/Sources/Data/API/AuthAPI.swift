import Foundation

final class AuthAPI {
    private let client: APIClient
    init(client: APIClient) { self.client = client }

    func register(_ request: RegisterRequestDTO) async throws -> AuthResponseDTO {
        try await client.send(Endpoint(
            path: "api/auth/register",
            method: .post,
            body: Endpoint.withJSONBody(request, encoder: client.encoder),
            requiresAuth: false
        ))
    }

    func login(_ request: LoginRequestDTO) async throws -> AuthResponseDTO {
        try await client.send(Endpoint(
            path: "api/auth/login",
            method: .post,
            body: Endpoint.withJSONBody(request, encoder: client.encoder),
            requiresAuth: false
        ))
    }
}
