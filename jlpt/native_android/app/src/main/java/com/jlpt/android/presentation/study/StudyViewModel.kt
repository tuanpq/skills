package com.jlpt.android.presentation.study

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.jlpt.android.domain.model.Grammar
import com.jlpt.android.domain.model.JlptLevel
import com.jlpt.android.domain.model.Kanji
import com.jlpt.android.domain.model.StudyItem
import com.jlpt.android.domain.model.StudyItemType
import com.jlpt.android.domain.model.StudyStatus
import com.jlpt.android.domain.model.Vocabulary
import com.jlpt.android.domain.usecase.study.GetGrammarStudyUseCase
import com.jlpt.android.domain.usecase.study.GetKanjiStudyUseCase
import com.jlpt.android.domain.usecase.study.GetVocabularyStudyUseCase
import com.jlpt.android.domain.usecase.study.UpdateStudyProgressUseCase
import com.jlpt.android.domain.util.AppResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class StudyUiState(
    val level: JlptLevel = JlptLevel.N5,
    val type: StudyItemType = StudyItemType.VOCABULARY,
    val vocabItems: List<StudyItem<Vocabulary>> = emptyList(),
    val kanjiItems: List<StudyItem<Kanji>> = emptyList(),
    val grammarItems: List<StudyItem<Grammar>> = emptyList(),
    val currentIndex: Int = 0,
    val isFlipped: Boolean = false,
    val isLoading: Boolean = false,
    val error: String? = null
) {
    val currentCount: Int
        get() = when (type) {
            StudyItemType.VOCABULARY -> vocabItems.size
            StudyItemType.KANJI -> kanjiItems.size
            StudyItemType.GRAMMAR -> grammarItems.size
        }
}

@HiltViewModel
class StudyViewModel @Inject constructor(
    private val getVocabularyStudy: GetVocabularyStudyUseCase,
    private val getKanjiStudy: GetKanjiStudyUseCase,
    private val getGrammarStudy: GetGrammarStudyUseCase,
    private val updateStudyProgress: UpdateStudyProgressUseCase
) : ViewModel() {

    private val _uiState = MutableStateFlow(StudyUiState())
    val uiState: StateFlow<StudyUiState> = _uiState.asStateFlow()

    init {
        load()
    }

    fun selectType(type: StudyItemType) {
        _uiState.update { it.copy(type = type, currentIndex = 0, isFlipped = false) }
        load()
    }

    fun selectLevel(level: JlptLevel) {
        _uiState.update { it.copy(level = level, currentIndex = 0, isFlipped = false) }
        load()
    }

    fun flip() = _uiState.update { it.copy(isFlipped = !it.isFlipped) }

    fun next() = _uiState.update {
        if (it.currentCount == 0) it else it.copy(currentIndex = (it.currentIndex + 1) % it.currentCount, isFlipped = false)
    }

    fun previous() = _uiState.update {
        if (it.currentCount == 0) it else {
            val newIndex = if (it.currentIndex == 0) it.currentCount - 1 else it.currentIndex - 1
            it.copy(currentIndex = newIndex, isFlipped = false)
        }
    }

    fun load() {
        val level = _uiState.value.level
        val type = _uiState.value.type
        viewModelScope.launch {
            _uiState.update { it.copy(isLoading = true, error = null) }
            when (type) {
                StudyItemType.VOCABULARY -> when (val result = getVocabularyStudy(level, dueOnly = false)) {
                    is AppResult.Success -> _uiState.update { it.copy(isLoading = false, vocabItems = result.data) }
                    is AppResult.Failure -> _uiState.update { it.copy(isLoading = false, error = result.message) }
                }
                StudyItemType.KANJI -> when (val result = getKanjiStudy(level, dueOnly = false)) {
                    is AppResult.Success -> _uiState.update { it.copy(isLoading = false, kanjiItems = result.data) }
                    is AppResult.Failure -> _uiState.update { it.copy(isLoading = false, error = result.message) }
                }
                StudyItemType.GRAMMAR -> when (val result = getGrammarStudy(level, dueOnly = false)) {
                    is AppResult.Success -> _uiState.update { it.copy(isLoading = false, grammarItems = result.data) }
                    is AppResult.Failure -> _uiState.update { it.copy(isLoading = false, error = result.message) }
                }
            }
        }
    }

    /** Manually sets NEW/LEARNING/MASTERED for the currently shown card, independent of SRS review. */
    fun markStatus(status: StudyStatus) {
        val state = _uiState.value
        val itemId = when (state.type) {
            StudyItemType.VOCABULARY -> state.vocabItems.getOrNull(state.currentIndex)?.item?.id
            StudyItemType.KANJI -> state.kanjiItems.getOrNull(state.currentIndex)?.item?.id
            StudyItemType.GRAMMAR -> state.grammarItems.getOrNull(state.currentIndex)?.item?.id
        } ?: return
        viewModelScope.launch {
            when (updateStudyProgress(state.type, itemId, status)) {
                is AppResult.Success -> {
                    _uiState.update {
                        when (it.type) {
                            StudyItemType.VOCABULARY -> it.copy(
                                vocabItems = it.vocabItems.mapIndexed { i, si -> if (i == it.currentIndex) si.copy(status = status) else si }
                            )
                            StudyItemType.KANJI -> it.copy(
                                kanjiItems = it.kanjiItems.mapIndexed { i, si -> if (i == it.currentIndex) si.copy(status = status) else si }
                            )
                            StudyItemType.GRAMMAR -> it.copy(
                                grammarItems = it.grammarItems.mapIndexed { i, si -> if (i == it.currentIndex) si.copy(status = status) else si }
                            )
                        }
                    }
                    next()
                }
                is AppResult.Failure -> Unit
            }
        }
    }
}
