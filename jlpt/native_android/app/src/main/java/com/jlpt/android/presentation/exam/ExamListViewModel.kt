package com.jlpt.android.presentation.exam

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.jlpt.android.domain.model.Attempt
import com.jlpt.android.domain.model.ExamSummary
import com.jlpt.android.domain.model.JlptLevel
import com.jlpt.android.domain.model.SkillType
import com.jlpt.android.domain.usecase.exam.GetAttemptHistoryUseCase
import com.jlpt.android.domain.usecase.exam.ListExamsUseCase
import com.jlpt.android.domain.usecase.exam.StartAttemptUseCase
import com.jlpt.android.domain.util.AppResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class ExamListUiState(
    val level: JlptLevel = JlptLevel.N5,
    val skill: SkillType? = null,
    val showHistory: Boolean = false,
    val exams: List<ExamSummary> = emptyList(),
    val history: List<Attempt> = emptyList(),
    val isLoading: Boolean = true,
    val isStarting: Boolean = false,
    val error: String? = null
)

@HiltViewModel
class ExamListViewModel @Inject constructor(
    private val listExams: ListExamsUseCase,
    private val startAttempt: StartAttemptUseCase,
    private val getAttemptHistory: GetAttemptHistoryUseCase
) : ViewModel() {

    private val _uiState = MutableStateFlow(ExamListUiState())
    val uiState: StateFlow<ExamListUiState> = _uiState.asStateFlow()

    init {
        load()
    }

    fun selectLevel(level: JlptLevel) {
        _uiState.update { it.copy(level = level) }
        load()
    }

    fun selectSkill(skill: SkillType?) {
        _uiState.update { it.copy(skill = skill) }
        load()
    }

    fun toggleHistory(show: Boolean) {
        _uiState.update { it.copy(showHistory = show) }
        if (show) loadHistory() else load()
    }

    fun load() {
        val state = _uiState.value
        viewModelScope.launch {
            _uiState.update { it.copy(isLoading = true, error = null) }
            when (val result = listExams(state.level, state.skill)) {
                is AppResult.Success -> _uiState.update { it.copy(isLoading = false, exams = result.data) }
                is AppResult.Failure -> _uiState.update { it.copy(isLoading = false, error = result.message) }
            }
        }
    }

    private fun loadHistory() {
        viewModelScope.launch {
            _uiState.update { it.copy(isLoading = true, error = null) }
            when (val result = getAttemptHistory()) {
                is AppResult.Success -> _uiState.update { it.copy(isLoading = false, history = result.data) }
                is AppResult.Failure -> _uiState.update { it.copy(isLoading = false, error = result.message) }
            }
        }
    }

    fun startAttempt(examId: Long, onStarted: (Long) -> Unit) {
        viewModelScope.launch {
            _uiState.update { it.copy(isStarting = true, error = null) }
            when (val result = startAttempt(examId)) {
                is AppResult.Success -> {
                    _uiState.update { it.copy(isStarting = false) }
                    onStarted(result.data.id)
                }
                is AppResult.Failure -> _uiState.update { it.copy(isStarting = false, error = result.message) }
            }
        }
    }
}
