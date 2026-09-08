package com.jlpt.android.data.remote.api

import com.jlpt.android.data.remote.dto.GrammarStudyResponseDto
import com.jlpt.android.data.remote.dto.KanjiStudyResponseDto
import com.jlpt.android.data.remote.dto.ProgressSummaryResponseDto
import com.jlpt.android.data.remote.dto.ReviewRequestDto
import com.jlpt.android.data.remote.dto.ReviewResultResponseDto
import com.jlpt.android.data.remote.dto.UpdateProgressRequestDto
import com.jlpt.android.data.remote.dto.VocabularyStudyResponseDto
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Query

interface StudyApi {
    @GET("api/study/vocabulary")
    suspend fun getVocabulary(
        @Query("level") level: String,
        @Query("page") page: Int,
        @Query("size") size: Int
    ): List<VocabularyStudyResponseDto>

    @GET("api/study/kanji")
    suspend fun getKanji(
        @Query("level") level: String,
        @Query("page") page: Int,
        @Query("size") size: Int
    ): List<KanjiStudyResponseDto>

    @GET("api/study/grammar")
    suspend fun getGrammar(
        @Query("level") level: String,
        @Query("page") page: Int,
        @Query("size") size: Int
    ): List<GrammarStudyResponseDto>

    @GET("api/study/vocabulary/due")
    suspend fun getVocabularyDue(
        @Query("level") level: String,
        @Query("page") page: Int,
        @Query("size") size: Int
    ): List<VocabularyStudyResponseDto>

    @GET("api/study/kanji/due")
    suspend fun getKanjiDue(
        @Query("level") level: String,
        @Query("page") page: Int,
        @Query("size") size: Int
    ): List<KanjiStudyResponseDto>

    @GET("api/study/grammar/due")
    suspend fun getGrammarDue(
        @Query("level") level: String,
        @Query("page") page: Int,
        @Query("size") size: Int
    ): List<GrammarStudyResponseDto>

    @POST("api/study/progress")
    suspend fun updateProgress(@Body request: UpdateProgressRequestDto)

    @POST("api/study/review")
    suspend fun review(@Body request: ReviewRequestDto): ReviewResultResponseDto

    @GET("api/users/me/progress")
    suspend fun getProgressSummary(): ProgressSummaryResponseDto
}
