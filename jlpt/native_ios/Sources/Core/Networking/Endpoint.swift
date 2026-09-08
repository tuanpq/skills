import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

/// Describes one backend call; `APIClient` turns this into a `URLRequest` and attaches auth as needed.
struct Endpoint {
    var path: String
    var method: HTTPMethod = .get
    var query: [URLQueryItem] = []
    var body: Data? = nil
    /// The three `/api/auth/**` endpoints are public and must never carry a stale Authorization header.
    var requiresAuth: Bool = true

    static func withJSONBody<T: Encodable>(_ value: T, encoder: JSONEncoder) -> Data? {
        try? encoder.encode(value)
    }
}
