import Foundation

struct ChoiceOptionResponseDTO: Decodable {
    let id: Int64
    let choiceText: String
    let displayOrder: Int
}

struct QuestionForAttemptResponseDTO: Decodable {
    let id: Int64
    let skillType: SkillType
    let questionText: String
    let passageContent: String?
    let listeningAudioId: Int64?
    let choices: [ChoiceOptionResponseDTO]
}

struct ExamSummaryResponseDTO: Decodable {
    let id: Int64
    let level: JlptLevel
    let title: String
    let examType: ExamType
    let skillType: SkillType?
    let timeLimitMinutes: Int
    let questionCount: Int
}

struct ExamDetailResponseDTO: Decodable {
    let id: Int64
    let level: JlptLevel
    let title: String
    let examType: ExamType
    let skillType: SkillType?
    let timeLimitMinutes: Int
    let questions: [QuestionForAttemptResponseDTO]
}

struct AttemptResponseDTO: Decodable {
    let id: Int64
    let examId: Int64
    let examTitle: String
    let status: AttemptStatus
    let startedAt: String
    let submittedAt: String?
    let score: Int?
    let maxScore: Int?
    let questions: [QuestionForAttemptResponseDTO]
}

struct SubmitAnswerRequestDTO: Encodable {
    let questionId: Int64
    let selectedChoiceId: Int64?
}

struct AnswerResultResponseDTO: Decodable {
    let questionId: Int64
    let questionText: String
    let selectedChoiceId: Int64?
    let correctChoiceId: Int64
    let correct: Bool
    let explanation: String?
}

struct AttemptResultResponseDTO: Decodable {
    let attemptId: Int64
    let examId: Int64
    let score: Int?
    let maxScore: Int?
    let submittedAt: String?
    let answers: [AnswerResultResponseDTO]
}
