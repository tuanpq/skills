package com.jlpt.android.presentation.progress

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.jlpt.android.domain.model.ProgressSummary
import com.jlpt.android.domain.usecase.auth.LogoutUseCase
import com.jlpt.android.domain.usecase.study.GetProgressSummaryUseCase
import com.jlpt.android.domain.util.AppResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class ProgressUiState(
    val summary: ProgressSummary? = null,
    val isLoading: Boolean = true,
    val error: String? = null
)

@HiltViewModel
class ProgressViewModel @Inject constructor(
    private val getProgressSummary: GetProgressSummaryUseCase,
    private val logoutUseCase: LogoutUseCase
) : ViewModel() {

    private val _uiState = MutableStateFlow(ProgressUiState())
    val uiState: StateFlow<ProgressUiState> = _uiState.asStateFlow()

    init {
        load()
    }

    fun load() {
        viewModelScope.launch {
            _uiState.update { it.copy(isLoading = true, error = null) }
            when (val result = getProgressSummary()) {
                is AppResult.Success -> _uiState.update { it.copy(isLoading = false, summary = result.data) }
                is AppResult.Failure -> _uiState.update { it.copy(isLoading = false, error = result.message) }
            }
        }
    }

    fun logout() {
        viewModelScope.launch { logoutUseCase() }
    }
}
