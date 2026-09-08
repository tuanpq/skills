import Foundation

enum JlptLevel: String, Codable, CaseIterable, Identifiable {
    case n5 = "N5", n4 = "N4", n3 = "N3", n2 = "N2", n1 = "N1"
    var id: String { rawValue }
}

enum SkillType: String, Codable, CaseIterable, Identifiable {
    case vocabulary = "VOCABULARY"
    case grammar = "GRAMMAR"
    case reading = "READING"
    case listening = "LISTENING"
    var id: String { rawValue }
}

enum ExamType: String, Codable {
    case fullMock = "FULL_MOCK"
    case skillPractice = "SKILL_PRACTICE"
}

enum AttemptStatus: String, Codable {
    case inProgress = "IN_PROGRESS"
    case submitted = "SUBMITTED"
}

enum StudyItemType: String, Codable, CaseIterable, Identifiable {
    case vocabulary = "VOCABULARY"
    case kanji = "KANJI"
    case grammar = "GRAMMAR"
    var id: String { rawValue }
}

enum StudyStatus: String, Codable {
    case new = "NEW"
    case learning = "LEARNING"
    case mastered = "MASTERED"
}

enum UserRole: String, Codable {
    case user = "USER"
    case admin = "ADMIN"
}

/// Recall-quality buttons shown on the SRS review screen, mapped to the SM-2 0-5 scale.
enum ReviewQuality: Int, CaseIterable {
    case again = 0
    case hard = 3
    case good = 4
    case easy = 5

    var label: String {
        switch self {
        case .again: return "Lại"
        case .hard: return "Khó"
        case .good: return "Tốt"
        case .easy: return "Dễ"
        }
    }
}
