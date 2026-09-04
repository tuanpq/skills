export type JlptLevel = 'N5' | 'N4' | 'N3' | 'N2' | 'N1'
export type SkillType = 'VOCABULARY' | 'GRAMMAR' | 'READING' | 'LISTENING'
export type ExamType = 'FULL_MOCK' | 'SKILL_PRACTICE'
export type AttemptStatus = 'IN_PROGRESS' | 'SUBMITTED'
export type StudyItemType = 'VOCABULARY' | 'KANJI' | 'GRAMMAR'
export type StudyStatus = 'NEW' | 'LEARNING' | 'MASTERED'

export interface User {
  userId: number
  email: string
  displayName: string
  role: 'USER' | 'ADMIN'
}

export interface AuthResponse {
  accessToken: string
  refreshToken: string
  userId: number
  email: string
  displayName: string
  role: 'USER' | 'ADMIN'
}

export interface ApiPage<T> {
  content: T[]
  totalElements: number
  totalPages: number
  number: number
  size: number
}

export interface VocabularyItem {
  id: number
  level: JlptLevel
  word: string
  reading: string
  meaningVi: string
  meaningEn: string | null
  partOfSpeech: string | null
  exampleSentence: string | null
  exampleReading: string | null
  exampleMeaning: string | null
}

export interface KanjiItem {
  id: number
  level: JlptLevel
  character: string
  onyomi: string | null
  kunyomi: string | null
  meaningVi: string
  strokeCount: number | null
  exampleWords: string | null
}

export interface GrammarPoint {
  id: number
  level: JlptLevel
  pattern: string
  meaningVi: string
  meaningEn: string | null
  usageNote: string | null
  exampleSentence: string | null
  exampleMeaning: string | null
}

export interface VocabularyStudy {
  item: VocabularyItem
  status: StudyStatus
}

export interface KanjiStudy {
  item: KanjiItem
  status: StudyStatus
}

export interface GrammarStudy {
  item: GrammarPoint
  status: StudyStatus
}

export interface ListeningAudio {
  id: number
  level: JlptLevel
  title: string
  audioUrl: string | null
  transcript: string | null
  durationSeconds: number | null
}

export interface ExamSummary {
  id: number
  level: JlptLevel
  title: string
  examType: ExamType
  skillType: SkillType | null
  timeLimitMinutes: number
  questionCount: number
}

export interface ChoiceOption {
  id: number
  choiceText: string
  displayOrder: number
}

export interface QuestionForAttempt {
  id: number
  skillType: SkillType
  questionText: string
  passageContent: string | null
  listeningAudioId: number | null
  choices: ChoiceOption[]
}

export interface ExamDetail {
  id: number
  level: JlptLevel
  title: string
  examType: ExamType
  skillType: SkillType | null
  timeLimitMinutes: number
  questions: QuestionForAttempt[]
}

export interface Attempt {
  id: number
  examId: number
  examTitle: string
  status: AttemptStatus
  startedAt: string
  submittedAt: string | null
  score: number | null
  maxScore: number | null
  questions: QuestionForAttempt[]
}

export interface AnswerResult {
  questionId: number
  questionText: string
  selectedChoiceId: number | null
  correctChoiceId: number | null
  correct: boolean
  explanation: string | null
}

export interface AttemptResult {
  attemptId: number
  examId: number
  score: number
  maxScore: number
  submittedAt: string
  answers: AnswerResult[]
}

export interface ProgressSummary {
  countsByItemTypeAndStatus: Partial<Record<StudyItemType, Partial<Record<StudyStatus, number>>>>
}

export interface ReviewResult {
  status: StudyStatus
  intervalDays: number
  nextReviewAt: string
}

export interface ApiError {
  timestamp: string
  status: number
  error: string
  message: string
  details: string[]
}
