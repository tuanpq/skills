package com.jlpt.android.domain.util

/** Outcome of a repository/use-case call, carrying a human-readable message on failure. */
sealed class AppResult<out T> {
    data class Success<T>(val data: T) : AppResult<T>()
    data class Failure(val message: String, val cause: Throwable? = null) : AppResult<Nothing>()
}

inline fun <T, R> AppResult<T>.map(transform: (T) -> R): AppResult<R> = when (this) {
    is AppResult.Success -> AppResult.Success(transform(data))
    is AppResult.Failure -> this
}

inline fun <T> AppResult<T>.onSuccess(action: (T) -> Unit): AppResult<T> {
    if (this is AppResult.Success) action(data)
    return this
}

inline fun <T> AppResult<T>.onFailure(action: (String) -> Unit): AppResult<T> {
    if (this is AppResult.Failure) action(message)
    return this
}
