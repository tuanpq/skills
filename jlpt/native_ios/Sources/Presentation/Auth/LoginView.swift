import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    let onLoginSuccess: () -> Void
    let onNavigateToRegister: () -> Void

    init(container: AppContainer, onLoginSuccess: @escaping () -> Void, onNavigateToRegister: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(container: container))
        self.onLoginSuccess = onLoginSuccess
        self.onNavigateToRegister = onNavigateToRegister
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Spacer()

            Text("JLPT")
                .font(.largeTitle.bold())
            Text("Học và luyện thi JLPT N5 - N1")
                .font(.body)
                .foregroundStyle(.secondary)
                .padding(.bottom, 24)

            TextField("Email", text: $viewModel.email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)

            SecureField("Password", text: $viewModel.password)
                .textContentType(.password)
                .textFieldStyle(.roundedBorder)

            if let error = viewModel.error {
                Text(error)
                    .foregroundStyle(.red)
                    .font(.footnote)
            }

            Button {
                Task {
                    if await viewModel.login() { onLoginSuccess() }
                }
            } label: {
                if viewModel.isLoading {
                    ProgressView().frame(maxWidth: .infinity)
                } else {
                    Text("Đăng nhập").frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.isLoading)
            .padding(.top, 8)

            Button("Chưa có tài khoản? Đăng ký", action: onNavigateToRegister)
                .frame(maxWidth: .infinity)

            Spacer()
            Spacer()
        }
        .padding(24)
    }
}
