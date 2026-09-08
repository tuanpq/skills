import Foundation

struct VocabularyResponseDTO: Decodable {
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

struct KanjiResponseDTO: Decodable {
    let id: Int64
    let level: JlptLevel
    let character: String
    let onyomi: String?
    let kunyomi: String?
    let meaningVi: String
    let strokeCount: Int?
    let exampleWords: String?
}

struct GrammarResponseDTO: Decodable {
    let id: Int64
    let level: JlptLevel
    let pattern: String
    let meaningVi: String
    let meaningEn: String?
    let usageNote: String?
    let exampleSentence: String?
    let exampleMeaning: String?
}

struct PassageResponseDTO: Decodable {
    let id: Int64
    let level: JlptLevel
    let title: String
    let content: String
}

struct ListeningAudioResponseDTO: Decodable {
    let id: Int64
    let level: JlptLevel
    let title: String
    let audioUrl: String
    let transcript: String?
    let durationSeconds: Int?
}

/// Mirrors the subset of Spring Data's `Page<T>` JSON shape we actually use; unrecognized fields
/// (`pageable`, `sort`, `first`, `last`, ...) are ignored by `JSONDecoder` automatically.
struct PageDTO<T: Decodable>: Decodable {
    let content: [T]
    let totalElements: Int64?
    let totalPages: Int?
    let number: Int?
    let size: Int?
}
