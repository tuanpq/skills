import Foundation

extension VocabularyStudyResponseDTO {
    func toDomain() -> StudyItem<Vocabulary> { StudyItem(item: item.toDomain(), status: status) }
}

extension KanjiStudyResponseDTO {
    func toDomain() -> StudyItem<Kanji> { StudyItem(item: item.toDomain(), status: status) }
}

extension GrammarStudyResponseDTO {
    func toDomain() -> StudyItem<Grammar> { StudyItem(item: item.toDomain(), status: status) }
}

extension ReviewResultResponseDTO {
    func toDomain() -> ReviewResult {
        ReviewResult(status: status, intervalDays: intervalDays, nextReviewAt: ISO8601.parse(nextReviewAt))
    }
}

extension ProgressSummaryResponseDTO {
    func toDomain() -> ProgressSummary {
        var result: [StudyItemType: [StudyStatus: Int64]] = [:]
        for (typeKey, statusCounts) in countsByItemTypeAndStatus {
            guard let itemType = StudyItemType(rawValue: typeKey) else { continue }
            var counts: [StudyStatus: Int64] = [:]
            for (statusKey, count) in statusCounts {
                guard let status = StudyStatus(rawValue: statusKey) else { continue }
                counts[status] = count
            }
            result[itemType] = counts
        }
        return ProgressSummary(countsByItemTypeAndStatus: result)
    }
}
