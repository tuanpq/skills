package com.jlpt.android.domain.repository

import com.jlpt.android.domain.model.AuthSession
import com.jlpt.android.domain.model.JlptLevel
import com.jlpt.android.domain.util.AppResult
import kotlinx.coroutines.flow.Flow

interface AuthRepository {
    /** Emits the currently persisted session, or null when signed out. Restored on app start. */
    val session: Flow<AuthSession?>

    suspend fun login(email: String, password: String): AppResult<AuthSession>

    suspend fun register(
        email: String,
        password: String,
        displayName: String,
        targetLevel: JlptLevel?
    ): AppResult<AuthSession>

    suspend fun logout()
}
