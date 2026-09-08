package com.jlpt.android.data.repository

import com.jlpt.android.core.datastore.TokenDataStore
import com.jlpt.android.data.mapper.toDomain
import com.jlpt.android.data.remote.api.AuthApi
import com.jlpt.android.data.remote.dto.LoginRequestDto
import com.jlpt.android.data.remote.dto.RegisterRequestDto
import com.jlpt.android.data.remote.safeApiCall
import com.jlpt.android.domain.model.AuthSession
import com.jlpt.android.domain.model.JlptLevel
import com.jlpt.android.domain.repository.AuthRepository
import com.jlpt.android.domain.util.AppResult
import com.jlpt.android.domain.util.onSuccess
import kotlinx.coroutines.flow.Flow
import kotlinx.serialization.json.Json
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class AuthRepositoryImpl @Inject constructor(
    private val api: AuthApi,
    private val tokenDataStore: TokenDataStore,
    private val json: Json
) : AuthRepository {

    override val session: Flow<AuthSession?> = tokenDataStore.session

    override suspend fun login(email: String, password: String): AppResult<AuthSession> =
        safeApiCall(json) { api.login(LoginRequestDto(email, password)).toDomain() }
            .onSuccess { tokenDataStore.save(it) }

    override suspend fun register(
        email: String,
        password: String,
        displayName: String,
        targetLevel: JlptLevel?
    ): AppResult<AuthSession> =
        safeApiCall(json) {
            api.register(RegisterRequestDto(email, password, displayName, targetLevel)).toDomain()
        }.onSuccess { tokenDataStore.save(it) }

    override suspend fun logout() {
        tokenDataStore.clear()
    }
}
