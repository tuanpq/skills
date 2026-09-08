package com.jlpt.android.core.network

import com.jlpt.android.core.datastore.TokenDataStore
import okhttp3.Interceptor
import okhttp3.Response
import javax.inject.Inject

/** Attaches the current access token to every request except the public auth endpoints. */
class AuthInterceptor @Inject constructor(
    private val tokenDataStore: TokenDataStore
) : Interceptor {

    override fun intercept(chain: Interceptor.Chain): Response {
        val request = chain.request()
        if (request.url.encodedPath.startsWith("/api/auth/")) {
            return chain.proceed(request)
        }
        val accessToken = tokenDataStore.accessTokenBlocking()
        val authorized = if (accessToken != null) {
            request.newBuilder().header("Authorization", "Bearer $accessToken").build()
        } else {
            request
        }
        return chain.proceed(authorized)
    }
}
