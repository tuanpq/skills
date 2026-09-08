package com.jlpt.android.data.remote.dto

import com.jlpt.android.domain.model.JlptLevel
import kotlinx.serialization.Serializable

@Serializable
data class LoginRequestDto(
    val email: String,
    val password: String
)

@Serializable
data class RegisterRequestDto(
    val email: String,
    val password: String,
    val displayName: String,
    val targetLevel: JlptLevel? = null
)

@Serializable
data class RefreshRequestDto(
    val refreshToken: String
)

@Serializable
data class AuthResponseDto(
    val accessToken: String,
    val refreshToken: String,
    val userId: Long,
    val email: String,
    val displayName: String,
    val role: String
)
