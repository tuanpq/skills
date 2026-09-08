package com.jlpt.android.data.remote.api

import com.jlpt.android.data.remote.dto.AttemptResponseDto
import com.jlpt.android.data.remote.dto.AttemptResultResponseDto
import com.jlpt.android.data.remote.dto.ExamDetailResponseDto
import com.jlpt.android.data.remote.dto.ExamSummaryResponseDto
import com.jlpt.android.data.remote.dto.SubmitAnswerRequestDto
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.PUT
import retrofit2.http.Path
import retrofit2.http.Query

interface ExamApi {
    @GET("api/exams")
    suspend fun listExams(
        @Query("level") level: String,
        @Query("skill") skill: String? = null
    ): List<ExamSummaryResponseDto>

    @GET("api/exams/{id}")
    suspend fun getExam(@Path("id") id: Long): ExamDetailResponseDto

    @POST("api/exams/{id}/attempts")
    suspend fun startAttempt(@Path("id") id: Long): AttemptResponseDto

    @GET("api/attempts/{id}")
    suspend fun getAttempt(@Path("id") id: Long): AttemptResponseDto

    @PUT("api/attempts/{id}/answers")
    suspend fun submitAnswer(@Path("id") id: Long, @Body request: SubmitAnswerRequestDto)

    @POST("api/attempts/{id}/submit")
    suspend fun submitAttempt(@Path("id") id: Long): AttemptResultResponseDto

    @GET("api/attempts/{id}/result")
    suspend fun getAttemptResult(@Path("id") id: Long): AttemptResultResponseDto

    @GET("api/users/me/attempts")
    suspend fun getMyAttempts(): List<AttemptResponseDto>
}
