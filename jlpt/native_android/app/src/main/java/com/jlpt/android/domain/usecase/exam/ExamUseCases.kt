package com.jlpt.android.domain.usecase.exam

import com.jlpt.android.domain.model.Attempt
import com.jlpt.android.domain.model.AttemptResult
import com.jlpt.android.domain.model.ExamDetail
import com.jlpt.android.domain.model.ExamSummary
import com.jlpt.android.domain.model.JlptLevel
import com.jlpt.android.domain.model.SkillType
import com.jlpt.android.domain.repository.ExamRepository
import com.jlpt.android.domain.util.AppResult
import javax.inject.Inject

class ListExamsUseCase @Inject constructor(private val repository: ExamRepository) {
    suspend operator fun invoke(level: JlptLevel, skill: SkillType?): AppResult<List<ExamSummary>> =
        repository.listExams(level, skill)
}

class GetExamDetailUseCase @Inject constructor(private val repository: ExamRepository) {
    suspend operator fun invoke(id: Long): AppResult<ExamDetail> = repository.getExam(id)
}

class StartAttemptUseCase @Inject constructor(private val repository: ExamRepository) {
    suspend operator fun invoke(examId: Long): AppResult<Attempt> = repository.startAttempt(examId)
}

class GetAttemptUseCase @Inject constructor(private val repository: ExamRepository) {
    suspend operator fun invoke(id: Long): AppResult<Attempt> = repository.getAttempt(id)
}

class SubmitAnswerUseCase @Inject constructor(private val repository: ExamRepository) {
    suspend operator fun invoke(attemptId: Long, questionId: Long, selectedChoiceId: Long?): AppResult<Unit> =
        repository.submitAnswer(attemptId, questionId, selectedChoiceId)
}

class SubmitAttemptUseCase @Inject constructor(private val repository: ExamRepository) {
    suspend operator fun invoke(attemptId: Long): AppResult<AttemptResult> = repository.submitAttempt(attemptId)
}

class GetAttemptResultUseCase @Inject constructor(private val repository: ExamRepository) {
    suspend operator fun invoke(attemptId: Long): AppResult<AttemptResult> = repository.getAttemptResult(attemptId)
}

class GetAttemptHistoryUseCase @Inject constructor(private val repository: ExamRepository) {
    suspend operator fun invoke(): AppResult<List<Attempt>> = repository.getMyAttempts()
}
