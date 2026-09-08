import SwiftUI

struct ExamListView: View {
    @StateObject private var viewModel: ExamListViewModel
    let push: (AppRoute) -> Void

    init(container: AppContainer, push: @escaping (AppRoute) -> Void) {
        _viewModel = StateObject(wrappedValue: ExamListViewModel(container: container))
        self.push = push
    }

    var body: some View {
        VStack(spacing: 0) {
            Picker("", selection: $viewModel.showHistory) {
                Text("Đề luyện thi").tag(false)
                Text("Lịch sử").tag(true)
            }
            .pickerStyle(.segmented)
            .padding()

            if !viewModel.showHistory {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        LevelPicker(selected: $viewModel.level)
                        filterChip(label: "Tất cả", isSelected: viewModel.skill == nil) { viewModel.skill = nil }
                        ForEach(SkillType.allCases) { skill in
                            filterChip(label: String(skill.rawValue.prefix(4)), isSelected: viewModel.skill == skill) {
                                viewModel.skill = skill
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 8)
            }

            content
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            LoadingView()
        } else if let error = viewModel.error {
            ErrorStateView(message: error) { viewModel.showHistory ? viewModel.loadHistory() : viewModel.load() }
        } else if viewModel.showHistory {
            if viewModel.history.isEmpty {
                EmptyStateView(message: "Chưa có lịch sử làm bài.")
            } else {
                List(viewModel.history) { attempt in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(attempt.examTitle).font(.headline)
                        Text(attempt.status == .submitted ? "Điểm: \(attempt.score ?? 0)/\(attempt.maxScore ?? 0)" : "Đang làm dở")
                            .font(.subheadline)
                        Button(attempt.status == .submitted ? "Xem kết quả" : "Tiếp tục") {
                            push(attempt.status == .submitted ? .attemptResult(attemptId: attempt.id) : .examAttempt(attemptId: attempt.id))
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(.plain)
            }
        } else if viewModel.exams.isEmpty {
            EmptyStateView(message: "Không có đề luyện thi cho lựa chọn này.")
        } else {
            List(viewModel.exams) { exam in
                VStack(alignment: .leading, spacing: 6) {
                    Text(exam.title).font(.headline)
                    Text("\(exam.examType == .fullMock ? "FULL_MOCK" : "SKILL_PRACTICE") · \(exam.questionCount) câu · \(exam.timeLimitMinutes) phút")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Button("Bắt đầu") {
                        viewModel.startAttempt(examId: exam.id) { attemptId in
                            push(.examAttempt(attemptId: attemptId))
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.isStarting)
                }
                .padding(.vertical, 4)
            }
            .listStyle(.plain)
        }
    }

    private func filterChip(label: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(label)
                .font(.footnote.weight(.medium))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(isSelected ? Color.jlptRed : Color.secondary.opacity(0.12))
                .foregroundStyle(isSelected ? .white : .primary)
                .clipShape(Capsule())
        }
    }
}
