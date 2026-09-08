import Foundation

/// Thin async/await HTTP client used by every `Data/API/*Api` type. Attaches the current access
/// token to every request except `/api/auth/**`, and on a 401 asks `TokenStore` to refresh once
/// before retrying — mirroring the frontend's axios interceptor and the Android app's OkHttp
/// `Authenticator`.
final class APIClient {
    private let baseURL: URL
    private let urlSession: URLSession
    private let tokenStore: TokenStore
    let encoder: JSONEncoder
    let decoder: JSONDecoder

    init(baseURL: URL = APIConfig.baseURL, tokenStore: TokenStore, urlSession: URLSession = .shared) {
        self.baseURL = baseURL
        self.tokenStore = tokenStore
        self.urlSession = urlSession
        self.encoder = JSONEncoder()
        self.decoder = JSONDecoder()
    }

    func send<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let data = try await sendRaw(endpoint)
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decoding(error)
        }
    }

    /// For endpoints whose response body we don't care about (e.g. `PUT .../answers`).
    func sendNoContent(_ endpoint: Endpoint) async throws {
        _ = try await sendRaw(endpoint)
    }

    private func sendRaw(_ endpoint: Endpoint, isRetry: Bool = false) async throws -> Data {
        let request = try await buildRequest(endpoint)

        let data: Data
        let response: URLResponse
        do {
            (data, response) = try await urlSession.data(for: request)
        } catch {
            throw APIError.network(error)
        }

        guard let http = response as? HTTPURLResponse else {
            throw APIError.network(URLError(.badServerResponse))
        }

        if http.statusCode == 401, endpoint.requiresAuth, !isRetry {
            guard await tokenStore.refreshedAccessToken() != nil else {
                throw APIError.unauthenticated
            }
            return try await sendRaw(endpoint, isRetry: true)
        }

        guard (200..<300).contains(http.statusCode) else {
            let message = (try? decoder.decode(ErrorResponseDTO.self, from: data))?.message
                ?? HTTPURLResponse.localizedString(forStatusCode: http.statusCode)
            throw APIError.server(status: http.statusCode, message: message)
        }

        return data
    }

    private func buildRequest(_ endpoint: Endpoint) async throws -> URLRequest {
        var components = URLComponents(url: baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false)
        if !endpoint.query.isEmpty {
            components?.queryItems = endpoint.query
        }
        guard let url = components?.url else {
            throw APIError.network(URLError(.badURL))
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        if endpoint.body != nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        if endpoint.requiresAuth, let accessToken = await tokenStore.session?.accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        return request
    }
}
