package com.jlpt.android.domain.model

data class AuthSession(
    val accessToken: String,
    val refreshToken: String,
    val userId: Long,
    val email: String,
    val displayName: String,
    val role: UserRole
)
