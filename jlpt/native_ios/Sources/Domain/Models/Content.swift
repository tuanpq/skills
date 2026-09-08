import Foundation

struct Vocabulary: Identifiable, Equatable {
    let id: Int64
    let level: JlptLevel
    let word: String
    let reading: String
    let meaningVi: String
    let meaningEn: String?
    let partOfSpeech: String?
    let exampleSentence: String?
    let exampleReading: String?
    let exampleMeaning: String?
}

struct Kanji: Identifiable, Equatable {
    let id: Int64
    let level: JlptLevel
    let character: String
    let onyomi: String?
    let kunyomi: String?
    let meaningVi: String
    let strokeCount: Int?
    let exampleWords: String?
}

struct Grammar: Identifiable, Equatable {
    let id: Int64
    let level: JlptLevel
    let pattern: String
    let meaningVi: String
    let meaningEn: String?
    let usageNote: String?
    let exampleSentence: String?
    let exampleMeaning: String?
}

struct Passage: Identifiable, Equatable {
    let id: Int64
    let level: JlptLevel
    let title: String
    let content: String
}

struct ListeningAudio: Identifiable, Equatable {
    let id: Int64
    let level: JlptLevel
    let title: String
    let audioUrl: String
    let transcript: String?
    let durationSeconds: Int?
}
