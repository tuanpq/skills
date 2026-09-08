package com.jlpt.android.data.remote.dto

import com.jlpt.android.domain.model.AttemptStatus
import com.jlpt.android.domain.model.ExamType
import com.jlpt.android.domain.model.JlptLevel
import com.jlpt.android.domain.model.SkillType
import kotlinx.serialization.Serializable

@Serializable
data class ChoiceOptionResponseDto(
    val id: Long,
    val choiceText: String,
    val displayOrder: Int
)

@Serializable
data class QuestionForAttemptResponseDto(
    val id: Long,
    val skillType: SkillType,
    val questionText: String,
    val passageContent: String? = null,
    val listeningAudioId: Long? = null,
    val choices: List<ChoiceOptionResponseDto> = emptyList()
)

@Serializable
data class ExamSummaryResponseDto(
    val id: Long,
    val level: JlptLevel,
    val title: String,
    val examType: ExamType,
    val skillType: SkillType? = null,
    val timeLimitMinutes: Int,
    val questionCount: Int
)

@Serializable
data class ExamDetailResponseDto(
    val id: Long,
    val level: JlptLevel,
    val title: String,
    val examType: ExamType,
    val skillType: SkillType? = null,
    val timeLimitMinutes: Int,
    val questions: List<QuestionForAttemptResponseDto> = emptyList()
)

@Serializable
data class AttemptResponseDto(
    val id: Long,
    val examId: Long,
    val examTitle: String,
    val status: AttemptStatus,
    val startedAt: String,
    val submittedAt: String? = null,
    val score: Int? = null,
    val maxScore: Int? = null,
    val questions: List<QuestionForAttemptResponseDto> = emptyList()
)

@Serializable
data class SubmitAnswerRequestDto(
    val questionId: Long,
    val selectedChoiceId: Long? = null
)

@Serializable
data class AnswerResultResponseDto(
    val questionId: Long,
    val questionText: String,
    val selectedChoiceId: Long? = null,
    val correctChoiceId: Long,
    val correct: Boolean,
    val explanation: String? = null
)

@Serializable
data class AttemptResultResponseDto(
    val attemptId: Long,
    val examId: Long,
    val score: Int? = null,
    val maxScore: Int? = null,
    val submittedAt: String? = null,
    val answers: List<AnswerResultResponseDto> = emptyList()
)
