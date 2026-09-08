package com.jlpt.android.data.remote.dto

import com.jlpt.android.domain.model.StudyItemType
import com.jlpt.android.domain.model.StudyStatus
import kotlinx.serialization.Serializable

@Serializable
data class VocabularyStudyResponseDto(
    val item: VocabularyResponseDto,
    val status: StudyStatus
)

@Serializable
data class KanjiStudyResponseDto(
    val item: KanjiResponseDto,
    val status: StudyStatus
)

@Serializable
data class GrammarStudyResponseDto(
    val item: GrammarResponseDto,
    val status: StudyStatus
)

@Serializable
data class UpdateProgressRequestDto(
    val itemType: StudyItemType,
    val itemId: Long,
    val status: StudyStatus
)

@Serializable
data class ReviewRequestDto(
    val itemType: StudyItemType,
    val itemId: Long,
    val quality: Int
)

@Serializable
data class ReviewResultResponseDto(
    val status: StudyStatus,
    val intervalDays: Int,
    val nextReviewAt: String? = null
)

@Serializable
data class ProgressSummaryResponseDto(
    val countsByItemTypeAndStatus: Map<StudyItemType, Map<StudyStatus, Long>> = emptyMap()
)
