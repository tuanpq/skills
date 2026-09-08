import SwiftUI

struct AttemptResultView: View {
    @StateObject private var viewModel: AttemptResultViewModel

    init(container: AppContainer, attemptId: Int64) {
        _viewModel = StateObject(wrappedValue: AttemptResultViewModel(container: container, attemptId: attemptId))
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                LoadingView()
            } else if let error = viewModel.error {
                ErrorStateView(message: error) { Task { await viewModel.load() } }
            } else if let result = viewModel.result {
                List {
                    Section {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Điểm số").font(.footnote).foregroundStyle(.secondary)
                            Text("\(result.score ?? 0) / \(result.maxScore ?? 0)")
                                .font(.largeTitle.bold())
                        }
                        .padding(.vertical, 8)
                    }

                    Section {
                        ForEach(result.answers) { answer in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(answer.questionText).font(.body.weight(.medium))
                                Text(answer.correct ? "Chính xác" : "Chưa chính xác")
                                    .font(.footnote.weight(.semibold))
                                    .foregroundStyle(answer.correct ? .green : .red)
                                if let explanation = answer.explanation {
                                    Text(explanation).font(.body)
                                }
                            }
                            .padding(.vertical, 4)
                            .listRowBackground(answer.correct ? Color.green.opacity(0.12) : Color.red.opacity(0.12))
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("Kết quả")
        .navigationBarTitleDisplayMode(.inline)
    }
}
