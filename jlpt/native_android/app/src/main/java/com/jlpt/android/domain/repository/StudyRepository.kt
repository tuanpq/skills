package com.jlpt.android.domain.repository

import com.jlpt.android.domain.model.Grammar
import com.jlpt.android.domain.model.JlptLevel
import com.jlpt.android.domain.model.Kanji
import com.jlpt.android.domain.model.ProgressSummary
import com.jlpt.android.domain.model.ReviewResult
import com.jlpt.android.domain.model.StudyItem
import com.jlpt.android.domain.model.StudyItemType
import com.jlpt.android.domain.model.StudyStatus
import com.jlpt.android.domain.model.Vocabulary
import com.jlpt.android.domain.util.AppResult

interface StudyRepository {
    suspend fun getVocabularyProgress(level: JlptLevel, dueOnly: Boolean): AppResult<List<StudyItem<Vocabulary>>>
    suspend fun getKanjiProgress(level: JlptLevel, dueOnly: Boolean): AppResult<List<StudyItem<Kanji>>>
    suspend fun getGrammarProgress(level: JlptLevel, dueOnly: Boolean): AppResult<List<StudyItem<Grammar>>>

    suspend fun updateProgress(itemType: StudyItemType, itemId: Long, status: StudyStatus): AppResult<Unit>

    /** Submits a spaced-repetition recall score (0-5) for one item and returns its new schedule. */
    suspend fun submitReview(itemType: StudyItemType, itemId: Long, quality: Int): AppResult<ReviewResult>

    suspend fun getProgressSummary(): AppResult<ProgressSummary>
}
