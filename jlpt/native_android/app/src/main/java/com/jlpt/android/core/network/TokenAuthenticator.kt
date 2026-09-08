package com.jlpt.android.core.network

import com.jlpt.android.BuildConfig
import com.jlpt.android.core.datastore.TokenDataStore
import com.jlpt.android.data.remote.dto.AuthResponseDto
import com.jlpt.android.data.remote.dto.RefreshRequestDto
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import okhttp3.Authenticator
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.toRequestBody
import okhttp3.Response
import okhttp3.Route
import javax.inject.Inject
import javax.inject.Singleton

/**
 * Mirrors the frontend's axios interceptor: on a 401, calls `/api/auth/refresh` once (guarded by
 * a mutex so concurrent 401s only trigger a single refresh) and retries the original request with
 * the new access token. If the refresh itself fails, the session is cleared so the UI redirects
 * back to login.
 */
@Singleton
class TokenAuthenticator @Inject constructor(
    private val tokenDataStore: TokenDataStore
) : Authenticator {

    private val mutex = Mutex()
    private val json = Json { ignoreUnknownKeys = true }
    private val plainClient = OkHttpClient()

    override fun authenticate(route: Route?, response: Response): Request? {
        if (responseCount(response) >= 2) return null // already retried once, give up

        val refreshToken = tokenDataStore.refreshTokenBlocking() ?: return null

        val newAccessToken = runBlocking {
            mutex.withLock {
                // Another thread may have already refreshed while we waited for the lock.
                val current = tokenDataStore.accessTokenBlocking()
                val failedToken = response.request.header("Authorization")?.removePrefix("Bearer ")
                if (current != null && current != failedToken) {
                    current
                } else {
                    performRefresh(refreshToken)
                }
            }
        } ?: return null

        return response.request.newBuilder()
            .header("Authorization", "Bearer $newAccessToken")
            .build()
    }

    private fun performRefresh(refreshToken: String): String? {
        val body = json.encodeToString(RefreshRequestDto(refreshToken))
            .toRequestBody("application/json".toMediaType())
        val request = Request.Builder()
            .url(BuildConfig.API_BASE_URL + "api/auth/refresh")
            .post(body)
            .build()

        return runCatching {
            plainClient.newCall(request).execute().use { resp ->
                if (!resp.isSuccessful) {
                    tokenDataStore.clearBlocking()
                    return null
                }
                val auth = json.decodeFromString<AuthResponseDto>(resp.body!!.string())
                runBlocking { tokenDataStore.updateTokens(auth.accessToken, auth.refreshToken) }
                auth.accessToken
            }
        }.getOrElse {
            tokenDataStore.clearBlocking()
            null
        }
    }

    private fun responseCount(response: Response): Int {
        var result = 1
        var prior = response.priorResponse
        while (prior != null) {
            result++
            prior = prior.priorResponse
        }
        return result
    }
}
