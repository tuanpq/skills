package com.jlpt.android.domain.usecase.study

import com.jlpt.android.domain.model.Grammar
import com.jlpt.android.domain.model.JlptLevel
import com.jlpt.android.domain.model.Kanji
import com.jlpt.android.domain.model.ProgressSummary
import com.jlpt.android.domain.model.ReviewResult
import com.jlpt.android.domain.model.StudyItem
import com.jlpt.android.domain.model.StudyItemType
import com.jlpt.android.domain.model.StudyStatus
import com.jlpt.android.domain.model.Vocabulary
import com.jlpt.android.domain.repository.StudyRepository
import com.jlpt.android.domain.util.AppResult
import javax.inject.Inject

class GetVocabularyStudyUseCase @Inject constructor(private val repository: StudyRepository) {
    suspend operator fun invoke(level: JlptLevel, dueOnly: Boolean): AppResult<List<StudyItem<Vocabulary>>> =
        repository.getVocabularyProgress(level, dueOnly)
}

class GetKanjiStudyUseCase @Inject constructor(private val repository: StudyRepository) {
    suspend operator fun invoke(level: JlptLevel, dueOnly: Boolean): AppResult<List<StudyItem<Kanji>>> =
        repository.getKanjiProgress(level, dueOnly)
}

class GetGrammarStudyUseCase @Inject constructor(private val repository: StudyRepository) {
    suspend operator fun invoke(level: JlptLevel, dueOnly: Boolean): AppResult<List<StudyItem<Grammar>>> =
        repository.getGrammarProgress(level, dueOnly)
}

class UpdateStudyProgressUseCase @Inject constructor(private val repository: StudyRepository) {
    suspend operator fun invoke(itemType: StudyItemType, itemId: Long, status: StudyStatus): AppResult<Unit> =
        repository.updateProgress(itemType, itemId, status)
}

class SubmitReviewUseCase @Inject constructor(private val repository: StudyRepository) {
    suspend operator fun invoke(itemType: StudyItemType, itemId: Long, quality: Int): AppResult<ReviewResult> =
        repository.submitReview(itemType, itemId, quality)
}

class GetProgressSummaryUseCase @Inject constructor(private val repository: StudyRepository) {
    suspend operator fun invoke(): AppResult<ProgressSummary> = repository.getProgressSummary()
}
