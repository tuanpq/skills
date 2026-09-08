package com.jlpt.android.presentation.auth

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.jlpt.android.domain.model.JlptLevel
import com.jlpt.android.domain.usecase.auth.RegisterUseCase
import com.jlpt.android.domain.util.AppResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class RegisterUiState(
    val email: String = "",
    val password: String = "",
    val displayName: String = "",
    val targetLevel: JlptLevel? = JlptLevel.N5,
    val isLoading: Boolean = false,
    val error: String? = null
)

@HiltViewModel
class RegisterViewModel @Inject constructor(
    private val registerUseCase: RegisterUseCase
) : ViewModel() {

    private val _uiState = MutableStateFlow(RegisterUiState())
    val uiState: StateFlow<RegisterUiState> = _uiState.asStateFlow()

    fun onEmailChange(value: String) = _uiState.update { it.copy(email = value, error = null) }
    fun onPasswordChange(value: String) = _uiState.update { it.copy(password = value, error = null) }
    fun onDisplayNameChange(value: String) = _uiState.update { it.copy(displayName = value, error = null) }
    fun onTargetLevelChange(value: JlptLevel) = _uiState.update { it.copy(targetLevel = value) }

    fun register(onSuccess: () -> Unit) {
        val state = _uiState.value
        if (state.email.isBlank() || state.password.length < 8 || state.displayName.isBlank()) {
            _uiState.update { it.copy(error = "Please fill in all fields (password: min 8 characters)") }
            return
        }
        viewModelScope.launch {
            _uiState.update { it.copy(isLoading = true, error = null) }
            val result = registerUseCase(
                state.email.trim(),
                state.password,
                state.displayName.trim(),
                state.targetLevel
            )
            when (result) {
                is AppResult.Success -> {
                    _uiState.update { it.copy(isLoading = false) }
                    onSuccess()
                }
                is AppResult.Failure -> _uiState.update { it.copy(isLoading = false, error = result.message) }
            }
        }
    }
}
