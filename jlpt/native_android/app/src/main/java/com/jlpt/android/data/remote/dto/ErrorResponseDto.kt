package com.jlpt.android.data.remote.dto

import kotlinx.serialization.Serializable

@Serializable
data class ErrorResponseDto(
    val timestamp: String? = null,
    val status: Int = 0,
    val error: String? = null,
    val message: String? = null,
    val details: List<String> = emptyList()
)
