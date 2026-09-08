package com.jlpt.android.presentation.auth

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.jlpt.android.domain.model.AuthSession
import com.jlpt.android.domain.usecase.auth.LogoutUseCase
import com.jlpt.android.domain.usecase.auth.ObserveSessionUseCase
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch
import javax.inject.Inject

sealed interface SessionState {
    data object Loading : SessionState
    data class SignedIn(val session: AuthSession) : SessionState
    data object SignedOut : SessionState
}

/**
 * App-wide session holder: drives which nav graph (auth vs. main) is shown, and reacts when the
 * [com.jlpt.android.core.network.TokenAuthenticator] clears the session after a failed refresh.
 */
@HiltViewModel
class SessionViewModel @Inject constructor(
    observeSession: ObserveSessionUseCase,
    private val logoutUseCase: LogoutUseCase
) : ViewModel() {

    val state: StateFlow<SessionState> = observeSession()
        .map { session -> if (session != null) SessionState.SignedIn(session) else SessionState.SignedOut }
        .stateIn(viewModelScope, SharingStarted.WhileSubscribed(5_000), SessionState.Loading)

    fun logout() {
        viewModelScope.launch { logoutUseCase() }
    }
}
