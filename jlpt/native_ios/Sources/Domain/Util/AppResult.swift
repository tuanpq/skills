import Foundation

/// Outcome of a repository/use-case call, carrying a human-readable message on failure.
enum AppResult<T> {
    case success(T)
    case failure(message: String, cause: Error? = nil)

    func map<R>(_ transform: (T) -> R) -> AppResult<R> {
        switch self {
        case .success(let value): return .success(transform(value))
        case .failure(let message, let cause): return .failure(message: message, cause: cause)
        }
    }

    @discardableResult
    func onSuccess(_ action: (T) -> Void) -> AppResult<T> {
        if case .success(let value) = self { action(value) }
        return self
    }

    @discardableResult
    func onFailure(_ action: (String) -> Void) -> AppResult<T> {
        if case .failure(let message, _) = self { action(message) }
        return self
    }
}
