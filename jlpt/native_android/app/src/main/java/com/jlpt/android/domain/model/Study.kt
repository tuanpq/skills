package com.jlpt.android.domain.model

import java.time.Instant

data class StudyItem<T>(
    val item: T,
    val status: StudyStatus
)

data class ReviewResult(
    val status: StudyStatus,
    val intervalDays: Int,
    val nextReviewAt: Instant?
)

data class ProgressSummary(
    val countsByItemTypeAndStatus: Map<StudyItemType, Map<StudyStatus, Long>>
) {
    fun countFor(itemType: StudyItemType, status: StudyStatus): Long =
        countsByItemTypeAndStatus[itemType]?.get(status) ?: 0L

    fun totalFor(itemType: StudyItemType): Long =
        countsByItemTypeAndStatus[itemType]?.values?.sum() ?: 0L
}
