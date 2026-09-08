package com.jlpt.android.data.repository

import com.jlpt.android.data.mapper.toDomain
import com.jlpt.android.data.remote.api.ExamApi
import com.jlpt.android.data.remote.dto.SubmitAnswerRequestDto
import com.jlpt.android.data.remote.safeApiCall
import com.jlpt.android.domain.model.Attempt
import com.jlpt.android.domain.model.AttemptResult
import com.jlpt.android.domain.model.ExamDetail
import com.jlpt.android.domain.model.ExamSummary
import com.jlpt.android.domain.model.JlptLevel
import com.jlpt.android.domain.model.SkillType
import com.jlpt.android.domain.repository.ExamRepository
import com.jlpt.android.domain.util.AppResult
import kotlinx.serialization.json.Json
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class ExamRepositoryImpl @Inject constructor(
    private val api: ExamApi,
    private val json: Json
) : ExamRepository {

    override suspend fun listExams(level: JlptLevel, skill: SkillType?): AppResult<List<ExamSummary>> =
        safeApiCall(json) { api.listExams(level.name, skill?.name).map { it.toDomain() } }

    override suspend fun getExam(id: Long): AppResult<ExamDetail> =
        safeApiCall(json) { api.getExam(id).toDomain() }

    override suspend fun startAttempt(examId: Long): AppResult<Attempt> =
        safeApiCall(json) { api.startAttempt(examId).toDomain() }

    override suspend fun getAttempt(id: Long): AppResult<Attempt> =
        safeApiCall(json) { api.getAttempt(id).toDomain() }

    override suspend fun submitAnswer(attemptId: Long, questionId: Long, selectedChoiceId: Long?): AppResult<Unit> =
        safeApiCall(json) { api.submitAnswer(attemptId, SubmitAnswerRequestDto(questionId, selectedChoiceId)) }

    override suspend fun submitAttempt(attemptId: Long): AppResult<AttemptResult> =
        safeApiCall(json) { api.submitAttempt(attemptId).toDomain() }

    override suspend fun getAttemptResult(attemptId: Long): AppResult<AttemptResult> =
        safeApiCall(json) { api.getAttemptResult(attemptId).toDomain() }

    override suspend fun getMyAttempts(): AppResult<List<Attempt>> =
        safeApiCall(json) { api.getMyAttempts().map { it.toDomain() } }
}
