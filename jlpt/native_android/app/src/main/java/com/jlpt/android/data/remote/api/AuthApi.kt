package com.jlpt.android.data.remote.api

import com.jlpt.android.data.remote.dto.AuthResponseDto
import com.jlpt.android.data.remote.dto.LoginRequestDto
import com.jlpt.android.data.remote.dto.RefreshRequestDto
import com.jlpt.android.data.remote.dto.RegisterRequestDto
import retrofit2.http.Body
import retrofit2.http.POST

interface AuthApi {
    @POST("api/auth/register")
    suspend fun register(@Body request: RegisterRequestDto): AuthResponseDto

    @POST("api/auth/login")
    suspend fun login(@Body request: LoginRequestDto): AuthResponseDto

    @POST("api/auth/refresh")
    suspend fun refresh(@Body request: RefreshRequestDto): AuthResponseDto
}
