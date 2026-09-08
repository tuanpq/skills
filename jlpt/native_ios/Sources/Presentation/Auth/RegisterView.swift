import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel: RegisterViewModel
    let onRegisterSuccess: () -> Void
    let onNavigateToLogin: () -> Void

    init(container: AppContainer, onRegisterSuccess: @escaping () -> Void, onNavigateToLogin: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: RegisterViewModel(container: container))
        self.onRegisterSuccess = onRegisterSuccess
        self.onNavigateToLogin = onNavigateToLogin
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Tạo tài khoản")
                    .font(.largeTitle.bold())
                    .padding(.bottom, 12)

                TextField("Tên hiển thị", text: $viewModel.displayName)
                    .textFieldStyle(.roundedBorder)

                TextField("Email", text: $viewModel.email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)

                SecureField("Mật khẩu (tối thiểu 8 ký tự)", text: $viewModel.password)
                    .textContentType(.newPassword)
                    .textFieldStyle(.roundedBorder)

                Text("Mục tiêu trình độ")
                    .font(.subheadline.weight(.medium))
                    .padding(.top, 8)
                LevelPicker(selected: $viewModel.targetLevel)

                if let error = viewModel.error {
                    Text(error)
                        .foregroundStyle(.red)
                        .font(.footnote)
                }

                Button {
                    Task {
                        if await viewModel.register() { onRegisterSuccess() }
                    }
                } label: {
                    if viewModel.isLoading {
                        ProgressView().frame(maxWidth: .infinity)
                    } else {
                        Text("Đăng ký").frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isLoading)
                .padding(.top, 16)

                Button("Đã có tài khoản? Đăng nhập", action: onNavigateToLogin)
                    .frame(maxWidth: .infinity)
            }
            .padding(24)
        }
    }
}
