import SwiftUI

struct StudyView: View {
    @StateObject private var viewModel: StudyViewModel
    let push: (AppRoute) -> Void

    init(container: AppContainer, push: @escaping (AppRoute) -> Void) {
        _viewModel = StateObject(wrappedValue: StudyViewModel(container: container))
        self.push = push
    }

    var body: some View {
        VStack(spacing: 0) {
            Picker("Loại", selection: $viewModel.type) {
                ForEach(StudyItemType.allCases) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            HStack {
                LevelPicker(selected: $viewModel.level)
                Spacer()
                Button("Ôn tập SRS") { push(.review(itemType: viewModel.type)) }
                    .buttonStyle(.bordered)
            }
            .padding(.horizontal)
            .padding(.bottom, 8)

            if viewModel.isLoading && viewModel.currentCount == 0 {
                LoadingView()
            } else if let error = viewModel.error, viewModel.currentCount == 0 {
                ErrorStateView(message: error) { Task { await viewModel.load() } }
            } else if viewModel.currentCount == 0 {
                EmptyStateView(message: "Không có dữ liệu cho cấp độ này.")
            } else {
                VStack(spacing: 12) {
                    HStack {
                        Button {
                            viewModel.previous()
                        } label: {
                            Image(systemName: "chevron.left").font(.title2)
                        }

                        card
                            .frame(maxWidth: .infinity)
                            .aspectRatio(1.2, contentMode: .fit)

                        Button {
                            viewModel.next()
                        } label: {
                            Image(systemName: "chevron.right").font(.title2)
                        }
                    }
                    .padding(.horizontal)

                    Text("\(viewModel.currentIndex + 1) / \(viewModel.currentCount)")
                        .font(.footnote.weight(.medium))

                    HStack(spacing: 8) {
                        Button("Mới") { viewModel.markStatus(.new) }
                        Button("Đang học") { viewModel.markStatus(.learning) }
                        Button("Đã thuộc") { viewModel.markStatus(.mastered) }
                    }
                    .buttonStyle(.bordered)
                    .frame(maxWidth: .infinity)
                }
                .padding(.bottom)
                Spacer()
            }
        }
    }

    @ViewBuilder
    private var card: some View {
        switch viewModel.type {
        case .vocabulary:
            let vocabItem = viewModel.vocabItems[safe: viewModel.currentIndex]?.item
            FlashcardView(isFlipped: viewModel.isFlipped, onTap: viewModel.flip) {
                if let vocabItem { VocabularyFront(item: vocabItem) }
            } back: {
                if let vocabItem { VocabularyBack(item: vocabItem) }
            }
        case .kanji:
            let kanjiItem = viewModel.kanjiItems[safe: viewModel.currentIndex]?.item
            FlashcardView(isFlipped: viewModel.isFlipped, onTap: viewModel.flip) {
                if let kanjiItem { KanjiFront(item: kanjiItem) }
            } back: {
                if let kanjiItem { KanjiBack(item: kanjiItem) }
            }
        case .grammar:
            let grammarItem = viewModel.grammarItems[safe: viewModel.currentIndex]?.item
            FlashcardView(isFlipped: viewModel.isFlipped, onTap: viewModel.flip) {
                if let grammarItem { GrammarFront(item: grammarItem) }
            } back: {
                if let grammarItem { GrammarBack(item: grammarItem) }
            }
        }
    }
}
