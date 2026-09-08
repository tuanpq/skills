import Foundation

/// Mirrors the backend's `ErrorResponse` (see `GlobalExceptionHandler`) so failure messages shown
/// to the user come from the server when available.
struct ErrorResponseDTO: Decodable {
    let timestamp: String?
    let status: Int?
    let error: String?
    let message: String?
    let details: [String]?
}

enum APIError: Error {
    case network(Error)
    case server(status: Int, message: String)
    case decoding(Error)
    case unauthenticated

    var userMessage: String {
        switch self {
        case .network:
            return "Cannot reach the server. Check your connection and try again."
        case .server(_, let message):
            return message
        case .decoding:
            return "Unexpected response from the server."
        case .unauthenticated:
            return "Your session has expired. Please sign in again."
        }
    }
}
