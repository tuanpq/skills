import Foundation

extension VocabularyResponseDTO {
    func toDomain() -> Vocabulary {
        Vocabulary(
            id: id, level: level, word: word, reading: reading, meaningVi: meaningVi, meaningEn: meaningEn,
            partOfSpeech: partOfSpeech, exampleSentence: exampleSentence, exampleReading: exampleReading,
            exampleMeaning: exampleMeaning
        )
    }
}

extension KanjiResponseDTO {
    func toDomain() -> Kanji {
        Kanji(
            id: id, level: level, character: character, onyomi: onyomi, kunyomi: kunyomi, meaningVi: meaningVi,
            strokeCount: strokeCount, exampleWords: exampleWords
        )
    }
}

extension GrammarResponseDTO {
    func toDomain() -> Grammar {
        Grammar(
            id: id, level: level, pattern: pattern, meaningVi: meaningVi, meaningEn: meaningEn,
            usageNote: usageNote, exampleSentence: exampleSentence, exampleMeaning: exampleMeaning
        )
    }
}

extension PassageResponseDTO {
    func toDomain() -> Passage { Passage(id: id, level: level, title: title, content: content) }
}

extension ListeningAudioResponseDTO {
    func toDomain() -> ListeningAudio {
        ListeningAudio(id: id, level: level, title: title, audioUrl: audioUrl, transcript: transcript, durationSeconds: durationSeconds)
    }
}
