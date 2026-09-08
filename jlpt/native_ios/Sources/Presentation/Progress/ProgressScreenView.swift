import SwiftUI

struct ProgressScreenView: View {
    @StateObject private var viewModel: ProgressScreenViewModel

    init(container: AppContainer) {
        _viewModel = StateObject(wrappedValue: ProgressScreenViewModel(container: container))
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                LoadingView()
            } else if let error = viewModel.error {
                ErrorStateView(message: error) { Task { await viewModel.load() } }
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Tiến độ học tập").font(.largeTitle.bold())

                        if let summary = viewModel.summary {
                            ForEach(StudyItemType.allCases) { type in
                                let total = max(summary.total(for: type), 1)
                                let mastered = summary.count(for: type, status: .mastered)
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(type.rawValue).font(.title3.weight(.semibold))
                                    ProgressView(value: Double(mastered), total: Double(total))
                                        .tint(.jlptRed)
                                    Text("Đã thuộc \(mastered) / \(summary.total(for: type))")
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.secondary.opacity(0.12))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }

                        Button("Đăng xuất") {
                            Task { await viewModel.logout() }
                        }
                        .buttonStyle(.bordered)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 8)
                    }
                    .padding(20)
                }
            }
        }
        .navigationTitle("Tiến độ")
    }
}
