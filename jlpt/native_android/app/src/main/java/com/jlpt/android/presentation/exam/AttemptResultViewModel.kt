package com.jlpt.android.presentation.exam

import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.jlpt.android.domain.model.AttemptResult
import com.jlpt.android.domain.usecase.exam.GetAttemptResultUseCase
import com.jlpt.android.domain.util.AppResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class AttemptResultUiState(
    val result: AttemptResult? = null,
    val isLoading: Boolean = true,
    val error: String? = null
)

@HiltViewModel
class AttemptResultViewModel @Inject constructor(
    savedStateHandle: SavedStateHandle,
    private val getAttemptResult: GetAttemptResultUseCase
) : ViewModel() {

    private val attemptId: Long = checkNotNull(savedStateHandle.get<String>("attemptId")).toLong()

    private val _uiState = MutableStateFlow(AttemptResultUiState())
    val uiState: StateFlow<AttemptResultUiState> = _uiState.asStateFlow()

    init {
        load()
    }

    fun load() {
        viewModelScope.launch {
            _uiState.update { it.copy(isLoading = true, error = null) }
            when (val result = getAttemptResult(attemptId)) {
                is AppResult.Success -> _uiState.update { it.copy(isLoading = false, result = result.data) }
                is AppResult.Failure -> _uiState.update { it.copy(isLoading = false, error = result.message) }
            }
        }
    }
}
