package com.jlpt.android.domain.model

enum class JlptLevel {
    N5, N4, N3, N2, N1
}

enum class SkillType {
    VOCABULARY, GRAMMAR, READING, LISTENING
}

enum class ExamType {
    FULL_MOCK, SKILL_PRACTICE
}

enum class AttemptStatus {
    IN_PROGRESS, SUBMITTED
}

enum class StudyItemType {
    VOCABULARY, KANJI, GRAMMAR
}

enum class StudyStatus {
    NEW, LEARNING, MASTERED
}

enum class UserRole {
    USER, ADMIN
}

/** Recall-quality buttons shown on the SRS review screen, mapped to the SM-2 0-5 scale. */
enum class ReviewQuality(val score: Int) {
    AGAIN(0),
    HARD(3),
    GOOD(4),
    EASY(5)
}
