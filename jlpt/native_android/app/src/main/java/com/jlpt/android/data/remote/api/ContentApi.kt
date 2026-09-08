package com.jlpt.android.data.remote.api

import com.jlpt.android.data.remote.dto.GrammarResponseDto
import com.jlpt.android.data.remote.dto.KanjiResponseDto
import com.jlpt.android.data.remote.dto.ListeningAudioResponseDto
import com.jlpt.android.data.remote.dto.PageDto
import com.jlpt.android.data.remote.dto.PassageResponseDto
import com.jlpt.android.data.remote.dto.VocabularyResponseDto
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query

interface ContentApi {
    @GET("api/vocabulary")
    suspend fun getVocabulary(
        @Query("level") level: String,
        @Query("page") page: Int,
        @Query("size") size: Int
    ): PageDto<VocabularyResponseDto>

    @GET("api/kanji")
    suspend fun getKanji(
        @Query("level") level: String,
        @Query("page") page: Int,
        @Query("size") size: Int
    ): PageDto<KanjiResponseDto>

    @GET("api/grammar")
    suspend fun getGrammar(
        @Query("level") level: String,
        @Query("page") page: Int,
        @Query("size") size: Int
    ): PageDto<GrammarResponseDto>

    @GET("api/passages/{id}")
    suspend fun getPassage(@Path("id") id: Long): PassageResponseDto

    @GET("api/listening-audios/{id}")
    suspend fun getListeningAudio(@Path("id") id: Long): ListeningAudioResponseDto
}
