import SwiftUI

struct ExamAttemptView: View {
    @StateObject private var viewModel: ExamAttemptViewModel
    let onSubmitted: (Int64) -> Void

    init(container: AppContainer, attemptId: Int64, onSubmitted: @escaping (Int64) -> Void) {
        _viewModel = StateObject(wrappedValue: ExamAttemptViewModel(container: container, attemptId: attemptId))
        self.onSubmitted = onSubmitted
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                LoadingView()
            } else if let error = viewModel.error, viewModel.attempt == nil {
                ErrorStateView(message: error) { Task { await viewModel.load() } }
            } else if let attempt = viewModel.attempt {
                let question = attempt.questions[safe: viewModel.currentIndex]
                VStack(spacing: 0) {
                    if let question {
                        QuestionCardView(
                            question: question,
                            questionNumber: viewModel.currentIndex + 1,
                            selectedChoiceId: viewModel.selectedAnswers[question.id],
                            onSelectChoice: { viewModel.selectAnswer(questionId: question.id, choiceId: $0) },
                            isAudioPlaying: viewModel.isAudioPlaying && viewModel.playingAudioId == question.listeningAudioId,
                            isAudioLoading: viewModel.isAudioLoading && viewModel.playingAudioId == question.listeningAudioId,
                            onToggleAudio: viewModel.toggleAudio
                        )
                    }

                    Divider()

                    HStack {
                        Button("Trước") { viewModel.previous() }
                            .disabled(viewModel.currentIndex == 0)

                        Spacer()
                        Text("\(viewModel.currentIndex + 1) / \(attempt.questions.count)")
                            .font(.footnote.weight(.medium))
                        Spacer()

                        if viewModel.currentIndex < attempt.questions.count - 1 {
                            Button("Tiếp") { viewModel.next() }
                        } else {
                            Button {
                                Task { await viewModel.submit(onSubmitted: onSubmitted) }
                            } label: {
                                if viewModel.isSubmitting {
                                    ProgressView()
                                } else {
                                    Text("Nộp bài")
                                }
                            }
                            .buttonStyle(.borderedProminent)
                            .disabled(viewModel.isSubmitting)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(viewModel.attempt?.examTitle ?? "Làm bài")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            if let remaining = viewModel.remainingSeconds {
                ToolbarItem(placement: .topBarTrailing) {
                    Text(String(format: "%02d:%02d", remaining / 60, remaining % 60))
                        .font(.title3.monospacedDigit())
                }
            }
        }
        .onDisappear { viewModel.stopAudio() }
    }
}
