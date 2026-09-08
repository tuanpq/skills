package com.jlpt.android.domain.usecase.auth

import com.jlpt.android.domain.model.AuthSession
import com.jlpt.android.domain.model.JlptLevel
import com.jlpt.android.domain.repository.AuthRepository
import com.jlpt.android.domain.util.AppResult
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

class ObserveSessionUseCase @Inject constructor(
    private val repository: AuthRepository
) {
    operator fun invoke(): Flow<AuthSession?> = repository.session
}

class LoginUseCase @Inject constructor(
    private val repository: AuthRepository
) {
    suspend operator fun invoke(email: String, password: String): AppResult<AuthSession> =
        repository.login(email, password)
}

class RegisterUseCase @Inject constructor(
    private val repository: AuthRepository
) {
    suspend operator fun invoke(
        email: String,
        password: String,
        displayName: String,
        targetLevel: JlptLevel?
    ): AppResult<AuthSession> = repository.register(email, password, displayName, targetLevel)
}

class LogoutUseCase @Inject constructor(
    private val repository: AuthRepository
) {
    suspend operator fun invoke() = repository.logout()
}
