package com.jlpt.backend.dto.auth;

public record AuthResponse(
        String accessToken,
        String refreshToken,
        Long userId,
        String email,
        String displayName,
        String role
) {
}
