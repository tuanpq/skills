package com.jlpt.android.data.mapper

import com.jlpt.android.data.remote.dto.AuthResponseDto
import com.jlpt.android.domain.model.AuthSession
import com.jlpt.android.domain.model.UserRole

fun AuthResponseDto.toDomain() = AuthSession(
    accessToken = accessToken,
    refreshToken = refreshToken,
    userId = userId,
    email = email,
    displayName = displayName,
    role = runCatching { UserRole.valueOf(role) }.getOrDefault(UserRole.USER)
)
