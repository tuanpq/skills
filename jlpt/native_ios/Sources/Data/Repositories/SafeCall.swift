import Foundation

/// Runs a throwing API call, converting any failure into `AppResult.failure` with a message read
/// from the backend's `ErrorResponse` body when available (`APIError.userMessage`).
func safeCall<T>(_ block: () async throws -> T) async -> AppResult<T> {
    do {
        return .success(try await block())
    } catch let error as APIError {
        return .failure(message: error.userMessage, cause: error)
    } catch {
        return .failure(message: error.localizedDescription, cause: error)
    }
}
