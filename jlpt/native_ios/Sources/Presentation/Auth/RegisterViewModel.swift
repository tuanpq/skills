import Foundation

@MainActor
final class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var displayName: String = ""
    @Published var targetLevel: JlptLevel = .n5
    @Published private(set) var isLoading = false
    @Published var error: String?

    private let registerUseCase: RegisterUseCase

    init(container: AppContainer) {
        registerUseCase = container.register
    }

    func register() async -> Bool {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 8,
              !displayName.trimmingCharacters(in: .whitespaces).isEmpty else {
            error = "Please fill in all fields (password: min 8 characters)"
            return false
        }
        isLoading = true
        error = nil
        defer { isLoading = false }

        let result = await registerUseCase(
            email: email.trimmingCharacters(in: .whitespaces),
            password: password,
            displayName: displayName.trimmingCharacters(in: .whitespaces),
            targetLevel: targetLevel
        )
        switch result {
        case .success:
            return true
        case .failure(let message, _):
            error = message
            return false
        }
    }
}
