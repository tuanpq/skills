package com.jlpt.android.presentation.review

import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.jlpt.android.domain.model.Grammar
import com.jlpt.android.domain.model.JlptLevel
import com.jlpt.android.domain.model.Kanji
import com.jlpt.android.domain.model.ReviewQuality
import com.jlpt.android.domain.model.StudyItem
import com.jlpt.android.domain.model.StudyItemType
import com.jlpt.android.domain.model.Vocabulary
import com.jlpt.android.domain.usecase.study.GetGrammarStudyUseCase
import com.jlpt.android.domain.usecase.study.GetKanjiStudyUseCase
import com.jlpt.android.domain.usecase.study.GetVocabularyStudyUseCase
import com.jlpt.android.domain.usecase.study.SubmitReviewUseCase
import com.jlpt.android.domain.util.AppResult
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import javax.inject.Inject

data class ReviewUiState(
    val itemType: StudyItemType = StudyItemType.VOCABULARY,
    val level: JlptLevel = JlptLevel.N5,
    val vocabQueue: List<StudyItem<Vocabulary>> = emptyList(),
    val kanjiQueue: List<StudyItem<Kanji>> = emptyList(),
    val grammarQueue: List<StudyItem<Grammar>> = emptyList(),
    val isFlipped: Boolean = false,
    val isLoading: Boolean = true,
    val error: String? = null,
    val finished: Boolean = false
) {
    val remaining: Int
        get() = when (itemType) {
            StudyItemType.VOCABULARY -> vocabQueue.size
            StudyItemType.KANJI -> kanjiQueue.size
            StudyItemType.GRAMMAR -> grammarQueue.size
        }
}

@HiltViewModel
class ReviewViewModel @Inject constructor(
    savedStateHandle: SavedStateHandle,
    private val getVocabularyStudy: GetVocabularyStudyUseCase,
    private val getKanjiStudy: GetKanjiStudyUseCase,
    private val getGrammarStudy: GetGrammarStudyUseCase,
    private val submitReview: SubmitReviewUseCase
) : ViewModel() {

    private val itemType: StudyItemType = runCatching {
        StudyItemType.valueOf(savedStateHandle.get<String>("itemType").orEmpty().uppercase())
    }.getOrDefault(StudyItemType.VOCABULARY)

    private val _uiState = MutableStateFlow(ReviewUiState(itemType = itemType))
    val uiState: StateFlow<ReviewUiState> = _uiState.asStateFlow()

    init {
        load()
    }

    fun selectLevel(level: JlptLevel) {
        _uiState.update { it.copy(level = level, finished = false) }
        load()
    }

    fun flip() = _uiState.update { it.copy(isFlipped = !it.isFlipped) }

    fun load() {
        val level = _uiState.value.level
        viewModelScope.launch {
            _uiState.update { it.copy(isLoading = true, error = null) }
            when (itemType) {
                StudyItemType.VOCABULARY -> when (val result = getVocabularyStudy(level, dueOnly = true)) {
                    is AppResult.Success -> _uiState.update {
                        it.copy(isLoading = false, vocabQueue = result.data, finished = result.data.isEmpty())
                    }
                    is AppResult.Failure -> _uiState.update { it.copy(isLoading = false, error = result.message) }
                }
                StudyItemType.KANJI -> when (val result = getKanjiStudy(level, dueOnly = true)) {
                    is AppResult.Success -> _uiState.update {
                        it.copy(isLoading = false, kanjiQueue = result.data, finished = result.data.isEmpty())
                    }
                    is AppResult.Failure -> _uiState.update { it.copy(isLoading = false, error = result.message) }
                }
                StudyItemType.GRAMMAR -> when (val result = getGrammarStudy(level, dueOnly = true)) {
                    is AppResult.Success -> _uiState.update {
                        it.copy(isLoading = false, grammarQueue = result.data, finished = result.data.isEmpty())
                    }
                    is AppResult.Failure -> _uiState.update { it.copy(isLoading = false, error = result.message) }
                }
            }
        }
    }

    /** Rates recall quality for the head of the due queue, then advances (SM-2 scheduling on the backend). */
    fun rate(quality: ReviewQuality) {
        val state = _uiState.value
        val itemId = when (state.itemType) {
            StudyItemType.VOCABULARY -> state.vocabQueue.firstOrNull()?.item?.id
            StudyItemType.KANJI -> state.kanjiQueue.firstOrNull()?.item?.id
            StudyItemType.GRAMMAR -> state.grammarQueue.firstOrNull()?.item?.id
        } ?: return

        viewModelScope.launch {
            when (submitReview(state.itemType, itemId, quality.score)) {
                is AppResult.Success -> _uiState.update {
                    val popped = when (it.itemType) {
                        StudyItemType.VOCABULARY -> it.copy(vocabQueue = it.vocabQueue.drop(1))
                        StudyItemType.KANJI -> it.copy(kanjiQueue = it.kanjiQueue.drop(1))
                        StudyItemType.GRAMMAR -> it.copy(grammarQueue = it.grammarQueue.drop(1))
                    }
                    popped.copy(isFlipped = false, finished = popped.remaining == 0)
                }
                is AppResult.Failure -> Unit
            }
        }
    }
}
