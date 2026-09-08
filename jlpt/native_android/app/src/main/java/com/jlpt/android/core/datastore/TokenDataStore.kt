package com.jlpt.android.core.datastore

import android.content.Context
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.longPreferencesKey
import androidx.datastore.preferences.core.stringPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import com.jlpt.android.domain.model.AuthSession
import com.jlpt.android.domain.model.UserRole
import dagger.hilt.android.qualifiers.ApplicationContext
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.runBlocking
import javax.inject.Inject
import javax.inject.Singleton

private val Context.authDataStore by preferencesDataStore(name = "auth_session")

/**
 * Persists the JWT session (access + refresh token, user profile) so the app can restore the
 * signed-in state on cold start, mirroring `shared_preferences` in the Flutter app.
 */
@Singleton
class TokenDataStore @Inject constructor(
    @ApplicationContext private val context: Context
) {
    private object Keys {
        val ACCESS_TOKEN = stringPreferencesKey("access_token")
        val REFRESH_TOKEN = stringPreferencesKey("refresh_token")
        val USER_ID = longPreferencesKey("user_id")
        val EMAIL = stringPreferencesKey("email")
        val DISPLAY_NAME = stringPreferencesKey("display_name")
        val ROLE = stringPreferencesKey("role")
    }

    val session: Flow<AuthSession?> = context.authDataStore.data.map { prefs ->
        val accessToken = prefs[Keys.ACCESS_TOKEN] ?: return@map null
        val refreshToken = prefs[Keys.REFRESH_TOKEN] ?: return@map null
        val userId = prefs[Keys.USER_ID] ?: return@map null
        AuthSession(
            accessToken = accessToken,
            refreshToken = refreshToken,
            userId = userId,
            email = prefs[Keys.EMAIL].orEmpty(),
            displayName = prefs[Keys.DISPLAY_NAME].orEmpty(),
            role = runCatching { UserRole.valueOf(prefs[Keys.ROLE].orEmpty()) }.getOrDefault(UserRole.USER)
        )
    }

    suspend fun save(session: AuthSession) {
        context.authDataStore.edit { prefs ->
            prefs[Keys.ACCESS_TOKEN] = session.accessToken
            prefs[Keys.REFRESH_TOKEN] = session.refreshToken
            prefs[Keys.USER_ID] = session.userId
            prefs[Keys.EMAIL] = session.email
            prefs[Keys.DISPLAY_NAME] = session.displayName
            prefs[Keys.ROLE] = session.role.name
        }
    }

    suspend fun updateTokens(accessToken: String, refreshToken: String) {
        context.authDataStore.edit { prefs ->
            prefs[Keys.ACCESS_TOKEN] = accessToken
            prefs[Keys.REFRESH_TOKEN] = refreshToken
        }
    }

    suspend fun clear() {
        context.authDataStore.edit { it.clear() }
    }

    /** Synchronous snapshot for use from [okhttp3.Interceptor]/[okhttp3.Authenticator] callbacks. */
    fun accessTokenBlocking(): String? = runBlocking {
        context.authDataStore.data.first()[Keys.ACCESS_TOKEN]
    }

    fun refreshTokenBlocking(): String? = runBlocking {
        context.authDataStore.data.first()[Keys.REFRESH_TOKEN]
    }

    fun clearBlocking() = runBlocking {
        context.authDataStore.edit { it.clear() }
    }
}
