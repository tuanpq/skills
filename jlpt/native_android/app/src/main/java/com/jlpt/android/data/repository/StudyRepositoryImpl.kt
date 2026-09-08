package com.jlpt.android.data.repository

import com.jlpt.android.data.mapper.toDomain
import com.jlpt.android.data.remote.api.StudyApi
import com.jlpt.android.data.remote.dto.ReviewRequestDto
import com.jlpt.android.data.remote.dto.UpdateProgressRequestDto
import com.jlpt.android.data.remote.safeApiCall
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
import kotlinx.serialization.json.Json
import javax.inject.Inject
import javax.inject.Singleton

private const val PAGE_SIZE = 200

@Singleton
class StudyRepositoryImpl @Inject constructor(
    private val api: StudyApi,
    private val json: Json
) : StudyRepository {

    override suspend fun getVocabularyProgress(
        level: JlptLevel,
        dueOnly: Boolean
    ): AppResult<List<StudyItem<Vocabulary>>> = safeApiCall(json) {
        val response = if (dueOnly) {
            api.getVocabularyDue(level.name, 0, PAGE_SIZE)
        } else {
            api.getVocabulary(level.name, 0, PAGE_SIZE)
        }
        response.map { it.toDomain() }
    }

    override suspend fun getKanjiProgress(
        level: JlptLevel,
        dueOnly: Boolean
    ): AppResult<List<StudyItem<Kanji>>> = safeApiCall(json) {
        val response = if (dueOnly) api.getKanjiDue(level.name, 0, PAGE_SIZE) else api.getKanji(level.name, 0, PAGE_SIZE)
        response.map { it.toDomain() }
    }

    override suspend fun getGrammarProgress(
        level: JlptLevel,
        dueOnly: Boolean
    ): AppResult<List<StudyItem<Grammar>>> = safeApiCall(json) {
        val response = if (dueOnly) {
            api.getGrammarDue(level.name, 0, PAGE_SIZE)
        } else {
            api.getGrammar(level.name, 0, PAGE_SIZE)
        }
        response.map { it.toDomain() }
    }

    override suspend fun updateProgress(itemType: StudyItemType, itemId: Long, status: StudyStatus): AppResult<Unit> =
        safeApiCall(json) { api.updateProgress(UpdateProgressRequestDto(itemType, itemId, status)) }

    override suspend fun submitReview(itemType: StudyItemType, itemId: Long, quality: Int): AppResult<ReviewResult> =
        safeApiCall(json) { api.review(ReviewRequestDto(itemType, itemId, quality)).toDomain() }

    override suspend fun getProgressSummary(): AppResult<ProgressSummary> =
        safeApiCall(json) { api.getProgressSummary().toDomain() }
}
