package com.jlpt.android.data.mapper

import com.jlpt.android.data.remote.dto.AnswerResultResponseDto
import com.jlpt.android.data.remote.dto.AttemptResponseDto
import com.jlpt.android.data.remote.dto.AttemptResultResponseDto
import com.jlpt.android.data.remote.dto.ChoiceOptionResponseDto
import com.jlpt.android.data.remote.dto.ExamDetailResponseDto
import com.jlpt.android.data.remote.dto.ExamSummaryResponseDto
import com.jlpt.android.data.remote.dto.QuestionForAttemptResponseDto
import com.jlpt.android.domain.model.AnswerResult
import com.jlpt.android.domain.model.Attempt
import com.jlpt.android.domain.model.AttemptResult
import com.jlpt.android.domain.model.ChoiceOption
import com.jlpt.android.domain.model.ExamDetail
import com.jlpt.android.domain.model.ExamQuestion
import com.jlpt.android.domain.model.ExamSummary

fun ChoiceOptionResponseDto.toDomain() = ChoiceOption(id = id, choiceText = choiceText, displayOrder = displayOrder)

fun QuestionForAttemptResponseDto.toDomain() = ExamQuestion(
    id = id,
    skillType = skillType,
    questionText = questionText,
    passageContent = passageContent,
    listeningAudioId = listeningAudioId,
    choices = choices.map { it.toDomain() }
)

fun ExamSummaryResponseDto.toDomain() = ExamSummary(
    id = id,
    level = level,
    title = title,
    examType = examType,
    skillType = skillType,
    timeLimitMinutes = timeLimitMinutes,
    questionCount = questionCount
)

fun ExamDetailResponseDto.toDomain() = ExamDetail(
    id = id,
    level = level,
    title = title,
    examType = examType,
    skillType = skillType,
    timeLimitMinutes = timeLimitMinutes,
    questions = questions.map { it.toDomain() }
)

fun AttemptResponseDto.toDomain() = Attempt(
    id = id,
    examId = examId,
    examTitle = examTitle,
    status = status,
    startedAt = startedAt.toInstant(),
    submittedAt = submittedAt.toInstantOrNull(),
    score = score,
    maxScore = maxScore,
    questions = questions.map { it.toDomain() }
)

fun AnswerResultResponseDto.toDomain() = AnswerResult(
    questionId = questionId,
    questionText = questionText,
    selectedChoiceId = selectedChoiceId,
    correctChoiceId = correctChoiceId,
    correct = correct,
    explanation = explanation
)

fun AttemptResultResponseDto.toDomain() = AttemptResult(
    attemptId = attemptId,
    examId = examId,
    score = score,
    maxScore = maxScore,
    submittedAt = submittedAt.toInstantOrNull(),
    answers = answers.map { it.toDomain() }
)
