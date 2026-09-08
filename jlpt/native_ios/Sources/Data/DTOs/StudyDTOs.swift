import Foundation

struct VocabularyStudyResponseDTO: Decodable {
    let item: VocabularyResponseDTO
    let status: StudyStatus
}

struct KanjiStudyResponseDTO: Decodable {
    let item: KanjiResponseDTO
    let status: StudyStatus
}

struct GrammarStudyResponseDTO: Decodable {
    let item: GrammarResponseDTO
    let status: StudyStatus
}

struct UpdateProgressRequestDTO: Encodable {
    let itemType: StudyItemType
    let itemId: Int64
    let status: StudyStatus
}

struct ReviewRequestDTO: Encodable {
    let itemType: StudyItemType
    let itemId: Int64
    let quality: Int
}

struct ReviewResultResponseDTO: Decodable {
    let status: StudyStatus
    let intervalDays: Int
    let nextReviewAt: String?
}

struct ProgressSummaryResponseDTO: Decodable {
    let countsByItemTypeAndStatus: [String: [String: Int64]]
}
