import SwiftUI

struct VocabularyFront: View {
    let item: Vocabulary
    var body: some View {
        VStack(spacing: 8) {
            Text(item.word).font(.system(size: 40))
            Text(item.reading).font(.title3)
        }
        .multilineTextAlignment(.center)
    }
}

struct VocabularyBack: View {
    let item: Vocabulary
    var body: some View {
        VStack(spacing: 8) {
            Text(item.meaningVi).font(.title3.weight(.semibold))
            if let partOfSpeech = item.partOfSpeech {
                Text(partOfSpeech).font(.subheadline).foregroundStyle(.secondary)
            }
            if let example = item.exampleSentence {
                Text(example).font(.body)
            }
            if let meaning = item.exampleMeaning {
                Text(meaning).font(.body)
            }
        }
        .multilineTextAlignment(.center)
    }
}

struct KanjiFront: View {
    let item: Kanji
    var body: some View {
        Text(item.character).font(.system(size: 72))
    }
}

struct KanjiBack: View {
    let item: Kanji
    var body: some View {
        VStack(spacing: 8) {
            Text(item.meaningVi).font(.title3.weight(.semibold))
            if let onyomi = item.onyomi { Text("Onyomi: \(onyomi)").font(.body) }
            if let kunyomi = item.kunyomi { Text("Kunyomi: \(kunyomi)").font(.body) }
            if let words = item.exampleWords { Text(words).font(.body) }
        }
        .multilineTextAlignment(.center)
    }
}

struct GrammarFront: View {
    let item: Grammar
    var body: some View {
        Text(item.pattern).font(.title.weight(.bold)).multilineTextAlignment(.center)
    }
}

struct GrammarBack: View {
    let item: Grammar
    var body: some View {
        VStack(spacing: 8) {
            Text(item.meaningVi).font(.title3.weight(.semibold))
            if let note = item.usageNote { Text(note).font(.body) }
            if let example = item.exampleSentence { Text(example).font(.body) }
            if let meaning = item.exampleMeaning { Text(meaning).font(.body) }
        }
        .multilineTextAlignment(.center)
    }
}
