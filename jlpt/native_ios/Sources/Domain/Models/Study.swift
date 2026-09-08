import Foundation

struct StudyItem<T>: Identifiable where T: Identifiable, T.ID == Int64 {
    let item: T
    var status: StudyStatus
    var id: Int64 { item.id }
}

struct ReviewResult {
    let status: StudyStatus
    let intervalDays: Int
    let nextReviewAt: Date?
}

struct ProgressSummary {
    let countsByItemTypeAndStatus: [StudyItemType: [StudyStatus: Int64]]

    func count(for itemType: StudyItemType, status: StudyStatus) -> Int64 {
        countsByItemTypeAndStatus[itemType]?[status] ?? 0
    }

    func total(for itemType: StudyItemType) -> Int64 {
        countsByItemTypeAndStatus[itemType]?.values.reduce(0, +) ?? 0
    }
}
