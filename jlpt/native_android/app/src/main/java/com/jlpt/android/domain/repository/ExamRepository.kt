package com.jlpt.android.domain.repository

import com.jlpt.android.domain.model.Attempt
import com.jlpt.android.domain.model.AttemptResult
import com.jlpt.android.domain.model.ExamDetail
import com.jlpt.android.domain.model.ExamSummary
import com.jlpt.android.domain.model.JlptLevel
import com.jlpt.android.domain.model.SkillType
import com.jlpt.android.domain.util.AppResult

interface ExamRepository {
    suspend fun listExams(level: JlptLevel, skill: SkillType?): AppResult<List<ExamSummary>>
    suspend fun getExam(id: Long): AppResult<ExamDetail>
    suspend fun startAttempt(examId: Long): AppResult<Attempt>
    suspend fun getAttempt(id: Long): AppResult<Attempt>
    suspend fun submitAnswer(attemptId: Long, questionId: Long, selectedChoiceId: Long?): AppResult<Unit>
    suspend fun submitAttempt(attemptId: Long): AppResult<AttemptResult>
    suspend fun getAttemptResult(attemptId: Long): AppResult<AttemptResult>
    suspend fun getMyAttempts(): AppResult<List<Attempt>>
}
