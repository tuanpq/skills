import SwiftUI

struct ReviewView: View {
    @StateObject private var viewModel: ReviewViewModel

    init(container: AppContainer, itemType: StudyItemType) {
        _viewModel = StateObject(wrappedValue: ReviewViewModel(container: container, itemType: itemType))
    }

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                LevelPicker(selected: $viewModel.level)
                Spacer()
                Text("Còn lại: \(viewModel.remaining)").font(.footnote.weight(.medium))
            }
            .padding(.horizontal)

            if viewModel.isLoading {
                LoadingView()
            } else if let error = viewModel.error {
                ErrorStateView(message: error) { viewModel.load() }
            } else if viewModel.finished {
                EmptyStateView(message: "🎉 Không còn thẻ nào đến hạn ôn tập!")
            } else {
                card
                    .padding(.horizontal)
                    .aspectRatio(1.1, contentMode: .fit)

                if viewModel.isFlipped {
                    HStack(spacing: 8) {
                        ForEach(ReviewQuality.allCases, id: \.self) { quality in
                            Button(quality.label) { viewModel.rate(quality) }
                                .buttonStyle(.borderedProminent)
                        }
                    }
                    .padding(.horizontal)
                } else {
                    Text("Chạm vào thẻ để xem đáp án")
                        .font(.footnote.weight(.medium))
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
        }
        .padding(.top, 12)
        .navigationTitle("Ôn tập SRS – \(viewModel.itemType.rawValue)")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var card: some View {
        switch viewModel.itemType {
        case .vocabulary:
            if let vocabItem = viewModel.vocabQueue.first?.item {
                FlashcardView(isFlipped: viewModel.isFlipped, onTap: viewModel.flip) {
                    VocabularyFront(item: vocabItem)
                } back: {
                    VocabularyBack(item: vocabItem)
                }
            }
        case .kanji:
            if let kanjiItem = viewModel.kanjiQueue.first?.item {
                FlashcardView(isFlipped: viewModel.isFlipped, onTap: viewModel.flip) {
                    KanjiFront(item: kanjiItem)
                } back: {
                    KanjiBack(item: kanjiItem)
                }
            }
        case .grammar:
            if let grammarItem = viewModel.grammarQueue.first?.item {
                FlashcardView(isFlipped: viewModel.isFlipped, onTap: viewModel.flip) {
                    GrammarFront(item: grammarItem)
                } back: {
                    GrammarBack(item: grammarItem)
                }
            }
        }
    }
}
