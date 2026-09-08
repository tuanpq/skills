package com.jlpt.android.data.mapper

import com.jlpt.android.data.remote.dto.GrammarStudyResponseDto
import com.jlpt.android.data.remote.dto.KanjiStudyResponseDto
import com.jlpt.android.data.remote.dto.ProgressSummaryResponseDto
import com.jlpt.android.data.remote.dto.ReviewResultResponseDto
import com.jlpt.android.data.remote.dto.VocabularyStudyResponseDto
import com.jlpt.android.domain.model.ProgressSummary
import com.jlpt.android.domain.model.ReviewResult
import com.jlpt.android.domain.model.StudyItem

fun VocabularyStudyResponseDto.toDomain() = StudyItem(item = item.toDomain(), status = status)
fun KanjiStudyResponseDto.toDomain() = StudyItem(item = item.toDomain(), status = status)
fun GrammarStudyResponseDto.toDomain() = StudyItem(item = item.toDomain(), status = status)

fun ReviewResultResponseDto.toDomain() = ReviewResult(
    status = status,
    intervalDays = intervalDays,
    nextReviewAt = nextReviewAt.toInstantOrNull()
)

fun ProgressSummaryResponseDto.toDomain() = ProgressSummary(countsByItemTypeAndStatus = countsByItemTypeAndStatus)
