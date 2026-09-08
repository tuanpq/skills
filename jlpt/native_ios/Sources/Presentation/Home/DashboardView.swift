import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel: DashboardViewModel

    init(container: AppContainer) {
        _viewModel = StateObject(wrappedValue: DashboardViewModel(container: container))
    }

    var body: some View {
        Group {
            if viewModel.isLoading && viewModel.progress == nil {
                LoadingView()
            } else if let error = viewModel.error, viewModel.progress == nil {
                ErrorStateView(message: error) { Task { await viewModel.load() } }
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Xin chào, \(viewModel.session?.displayName ?? "")")
                            .font(.largeTitle.bold())
                        Text("Vai trò: \(viewModel.session?.role.rawValue ?? "")")
                            .font(.body)
                            .foregroundStyle(.secondary)

                        if let progress = viewModel.progress {
                            ForEach(StudyItemType.allCases) { type in
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(type.rawValue)
                                        .font(.title3.weight(.semibold))
                                    Text(
                                        "Mới: \(progress.count(for: type, status: .new)) · " +
                                        "Đang học: \(progress.count(for: type, status: .learning)) · " +
                                        "Đã thuộc: \(progress.count(for: type, status: .mastered))"
                                    )
                                    .font(.body)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.secondary.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                    }
                    .padding(20)
                }
            }
        }
        .navigationTitle("Trang chủ")
    }
}
