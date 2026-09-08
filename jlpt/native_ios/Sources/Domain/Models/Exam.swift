import Foundation

struct ExamSummary: Identifiable, Equatable {
    let id: Int64
    let level: JlptLevel
    let title: String
    let examType: ExamType
    let skillType: SkillType?
    let timeLimitMinutes: Int
    let questionCount: Int
}

struct ChoiceOption: Identifiable, Equatable {
    let id: Int64
    let choiceText: String
    let displayOrder: Int
}

struct ExamQuestion: Identifiable, Equatable {
    let id: Int64
    let skillType: SkillType
    let questionText: String
    let passageContent: String?
    let listeningAudioId: Int64?
    let choices: [ChoiceOption]
}

struct ExamDetail: Identifiable, Equatable {
    let id: Int64
    let level: JlptLevel
    let title: String
    let examType: ExamType
    let skillType: SkillType?
    let timeLimitMinutes: Int
    let questions: [ExamQuestion]
}

struct Attempt: Identifiable, Equatable {
    let id: Int64
    let examId: Int64
    let examTitle: String
    let status: AttemptStatus
    let startedAt: Date
    let submittedAt: Date?
    let score: Int?
    let maxScore: Int?
    let questions: [ExamQuestion]
}

struct AnswerResult: Identifiable, Equatable {
    let questionId: Int64
    let questionText: String
    let selectedChoiceId: Int64?
    let correctChoiceId: Int64
    let correct: Bool
    let explanation: String?
    var id: Int64 { questionId }
}

struct AttemptResult: Identifiable, Equatable {
    let attemptId: Int64
    let examId: Int64
    let score: Int?
    let maxScore: Int?
    let submittedAt: Date?
    let answers: [AnswerResult]
    var id: Int64 { attemptId }
}
