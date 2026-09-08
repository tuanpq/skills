import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published private(set) var isLoading = false
    @Published var error: String?

    private let loginUseCase: LoginUseCase

    init(container: AppContainer) {
        loginUseCase = container.login
    }

    func login() async -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty, !password.isEmpty else {
            error = "Email and password are required"
            return false
        }
        isLoading = true
        error = nil
        defer { isLoading = false }

        let result = await loginUseCase(email: email.trimmingCharacters(in: .whitespaces), password: password)
        switch result {
        case .success:
            return true
        case .failure(let message, _):
            error = message
            return false
        }
    }
}
