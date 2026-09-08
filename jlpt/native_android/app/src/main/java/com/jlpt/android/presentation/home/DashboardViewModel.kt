package com.jlpt.android.presentation.home

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.jlpt.android.domain.model.AuthSession
import com.jlpt.android.domain.model.ProgressSummary
import com.jlpt.android.domain.usecase.auth.ObserveSessionUseCase
import com.jlpt.android.domain.usecase.study.GetProgressSummaryUseCase
import com.jlpt.android.domain.util.AppResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class DashboardUiState(
    val session: AuthSession? = null,
    val progress: ProgressSummary? = null,
    val isLoading: Boolean = true,
    val error: String? = null
)

@HiltViewModel
class DashboardViewModel @Inject constructor(
    observeSession: ObserveSessionUseCase,
    private val getProgressSummary: GetProgressSummaryUseCase
) : ViewModel() {

    private val _uiState = MutableStateFlow(DashboardUiState())
    val uiState: StateFlow<DashboardUiState> = _uiState.asStateFlow()

    init {
        viewModelScope.launch {
            observeSession().collect { session -> _uiState.update { it.copy(session = session) } }
        }
        load()
    }

    fun load() {
        viewModelScope.launch {
            _uiState.update { it.copy(isLoading = true, error = null) }
            when (val result = getProgressSummary()) {
                is AppResult.Success -> _uiState.update { it.copy(isLoading = false, progress = result.data) }
                is AppResult.Failure -> _uiState.update { it.copy(isLoading = false, error = result.message) }
            }
        }
    }
}
