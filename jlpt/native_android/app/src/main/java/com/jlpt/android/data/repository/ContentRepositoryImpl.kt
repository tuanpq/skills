package com.jlpt.android.data.repository

import com.jlpt.android.data.mapper.toDomain
import com.jlpt.android.data.remote.api.ContentApi
import com.jlpt.android.data.remote.safeApiCall
import com.jlpt.android.domain.model.Grammar
import com.jlpt.android.domain.model.JlptLevel
import com.jlpt.android.domain.model.Kanji
import com.jlpt.android.domain.model.ListeningAudio
import com.jlpt.android.domain.model.Passage
import com.jlpt.android.domain.model.Vocabulary
import com.jlpt.android.domain.repository.ContentRepository
import com.jlpt.android.domain.util.AppResult
import kotlinx.serialization.json.Json
import javax.inject.Inject
import javax.inject.Singleton

/** Each JLPT level's content set is small (see backend seed data), so one page fits it all. */
private const val PAGE_SIZE = 200

@Singleton
class ContentRepositoryImpl @Inject constructor(
    private val api: ContentApi,
    private val json: Json
) : ContentRepository {

    override suspend fun getVocabulary(level: JlptLevel): AppResult<List<Vocabulary>> =
        safeApiCall(json) { api.getVocabulary(level.name, 0, PAGE_SIZE).content.map { it.toDomain() } }

    override suspend fun getKanji(level: JlptLevel): AppResult<List<Kanji>> =
        safeApiCall(json) { api.getKanji(level.name, 0, PAGE_SIZE).content.map { it.toDomain() } }

    override suspend fun getGrammar(level: JlptLevel): AppResult<List<Grammar>> =
        safeApiCall(json) { api.getGrammar(level.name, 0, PAGE_SIZE).content.map { it.toDomain() } }

    override suspend fun getPassage(id: Long): AppResult<Passage> =
        safeApiCall(json) { api.getPassage(id).toDomain() }

    override suspend fun getListeningAudio(id: Long): AppResult<ListeningAudio> =
        safeApiCall(json) { api.getListeningAudio(id).toDomain() }
}
