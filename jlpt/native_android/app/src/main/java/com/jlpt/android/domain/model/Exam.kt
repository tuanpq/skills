package com.jlpt.android.domain.model

import java.time.Instant

data class ExamSummary(
    val id: Long,
    val level: JlptLevel,
    val title: String,
    val examType: ExamType,
    val skillType: SkillType?,
    val timeLimitMinutes: Int,
    val questionCount: Int
)

data class ChoiceOption(
    val id: Long,
    val choiceText: String,
    val displayOrder: Int
)

data class ExamQuestion(
    val id: Long,
    val skillType: SkillType,
    val questionText: String,
    val passageContent: String?,
    val listeningAudioId: Long?,
    val choices: List<ChoiceOption>
)

data class ExamDetail(
    val id: Long,
    val level: JlptLevel,
    val title: String,
    val examType: ExamType,
    val skillType: SkillType?,
    val timeLimitMinutes: Int,
    val questions: List<ExamQuestion>
)

data class Attempt(
    val id: Long,
    val examId: Long,
    val examTitle: String,
    val status: AttemptStatus,
    val startedAt: Instant,
    val submittedAt: Instant?,
    val score: Int?,
    val maxScore: Int?,
    val questions: List<ExamQuestion>
)

data class AnswerResult(
    val questionId: Long,
    val questionText: String,
    val selectedChoiceId: Long?,
    val correctChoiceId: Long,
    val correct: Boolean,
    val explanation: String?
)

data class AttemptResult(
    val attemptId: Long,
    val examId: Long,
    val score: Int?,
    val maxScore: Int?,
    val submittedAt: Instant?,
    val answers: List<AnswerResult>
)
