package com.jlpt.android.data.remote

import com.jlpt.android.data.remote.dto.ErrorResponseDto
import com.jlpt.android.domain.util.AppResult
import kotlinx.coroutines.CancellationException
import kotlinx.serialization.json.Json
import retrofit2.HttpException
import java.io.IOException

/**
 * Runs a Retrofit call, converting any failure into [AppResult.Failure] with a message read from
 * the backend's `ErrorResponse` body when present (see `GlobalExceptionHandler` on the backend).
 */
suspend fun <T> safeApiCall(json: Json, block: suspend () -> T): AppResult<T> = try {
    AppResult.Success(block())
} catch (e: CancellationException) {
    throw e
} catch (e: HttpException) {
    val message = e.response()?.errorBody()?.string()?.let { body ->
        runCatching { json.decodeFromString<ErrorResponseDto>(body).message }.getOrNull()
    } ?: e.message()
    AppResult.Failure(message ?: "Request failed", e)
} catch (e: IOException) {
    AppResult.Failure("Cannot reach the server. Check your connection and try again.", e)
} catch (e: Exception) {
    AppResult.Failure(e.message ?: "Unexpected error", e)
}
