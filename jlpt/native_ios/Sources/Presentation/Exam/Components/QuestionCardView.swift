import SwiftUI

struct QuestionCardView: View {
    let question: ExamQuestion
    let questionNumber: Int
    let selectedChoiceId: Int64?
    let onSelectChoice: (Int64) -> Void
    let isAudioPlaying: Bool
    let isAudioLoading: Bool
    let onToggleAudio: (Int64) -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text("Câu \(questionNumber)")
                    .font(.footnote.weight(.medium))
                    .foregroundStyle(.secondary)

                if question.skillType == .listening, let audioId = question.listeningAudioId {
                    Button {
                        onToggleAudio(audioId)
                    } label: {
                        HStack {
                            if isAudioLoading {
                                ProgressView()
                            } else {
                                Image(systemName: isAudioPlaying ? "pause.circle.fill" : "play.circle.fill")
                                    .font(.title2)
                            }
                            Text("Nghe đoạn hội thoại")
                        }
                    }
                    .buttonStyle(.bordered)
                }

                if let passage = question.passageContent {
                    Text(passage)
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.secondary.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                Text(question.questionText)
                    .font(.title3.weight(.semibold))

                VStack(alignment: .leading, spacing: 4) {
                    ForEach(question.choices.sorted { $0.displayOrder < $1.displayOrder }) { choice in
                        Button {
                            onSelectChoice(choice.id)
                        } label: {
                            HStack {
                                Image(systemName: choice.id == selectedChoiceId ? "largecircle.fill.circle" : "circle")
                                Text(choice.choiceText)
                                Spacer()
                            }
                            .contentShape(Rectangle())
                        }
                        .buttonStyle(.plain)
                        .padding(.vertical, 6)
                    }
                }
            }
            .padding()
        }
    }
}
