package com.jlpt.android.presentation.exam

import android.content.Context
import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import androidx.media3.common.MediaItem
import androidx.media3.common.Player
import androidx.media3.exoplayer.ExoPlayer
import com.jlpt.android.domain.model.Attempt
import com.jlpt.android.domain.usecase.content.GetListeningAudioUseCase
import com.jlpt.android.domain.usecase.exam.GetAttemptUseCase
import com.jlpt.android.domain.usecase.exam.GetExamDetailUseCase
import com.jlpt.android.domain.usecase.exam.SubmitAnswerUseCase
import com.jlpt.android.domain.usecase.exam.SubmitAttemptUseCase
import com.jlpt.android.domain.util.AppResult
import dagger.hilt.android.lifecycle.HiltViewModel
import dagger.hilt.android.qualifiers.ApplicationContext
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import java.time.Duration
import java.time.Instant
import javax.inject.Inject

data class ExamAttemptUiState(
    val attempt: Attempt? = null,
    val currentIndex: Int = 0,
    val selectedAnswers: Map<Long, Long?> = emptyMap(),
    val remainingSeconds: Int? = null,
    val isLoading: Boolean = true,
    val isSubmitting: Boolean = false,
    val error: String? = null,
    val playingAudioId: Long? = null,
    val isAudioPlaying: Boolean = false,
    val isAudioLoading: Boolean = false
)

@HiltViewModel
class ExamAttemptViewModel @Inject constructor(
    savedStateHandle: SavedStateHandle,
    private val getAttempt: GetAttemptUseCase,
    private val getExamDetail: GetExamDetailUseCase,
    private val submitAnswer: SubmitAnswerUseCase,
    private val submitAttempt: SubmitAttemptUseCase,
    private val getListeningAudio: GetListeningAudioUseCase,
    @ApplicationContext context: Context
) : ViewModel() {

    private val attemptId: Long = checkNotNull(savedStateHandle.get<String>("attemptId")).toLong()

    private val _uiState = MutableStateFlow(ExamAttemptUiState())
    val uiState: StateFlow<ExamAttemptUiState> = _uiState.asStateFlow()

    private var timerStarted = false

    private val player: ExoPlayer by lazy {
        ExoPlayer.Builder(context).build().apply {
            addListener(object : Player.Listener {
                override fun onIsPlayingChanged(isPlaying: Boolean) {
                    _uiState.update { it.copy(isAudioPlaying = isPlaying) }
                }
            })
        }
    }
    private var loadedAudioId: Long? = null

    init {
        load()
    }

    fun load() {
        viewModelScope.launch {
            _uiState.update { it.copy(isLoading = true, error = null) }
            when (val result = getAttempt(attemptId)) {
                is AppResult.Success -> {
                    _uiState.update { it.copy(isLoading = false, attempt = result.data) }
                    startTimer(result.data)
                }
                is AppResult.Failure -> _uiState.update { it.copy(isLoading = false, error = result.message) }
            }
        }
    }

    private fun startTimer(attempt: Attempt) {
        if (timerStarted) return
        timerStarted = true
        viewModelScope.launch {
            val examResult = getExamDetail(attempt.examId)
            val timeLimitMinutes = (examResult as? AppResult.Success)?.data?.timeLimitMinutes ?: return@launch
            val deadline = attempt.startedAt.plus(Duration.ofMinutes(timeLimitMinutes.toLong()))
            while (true) {
                val remaining = Duration.between(Instant.now(), deadline).seconds.toInt()
                if (remaining <= 0) {
                    _uiState.update { it.copy(remainingSeconds = 0) }
                    submit { }
                    break
                }
                _uiState.update { it.copy(remainingSeconds = remaining) }
                delay(1_000)
            }
        }
    }

    fun goTo(index: Int) = _uiState.update {
        val count = it.attempt?.questions?.size ?: 0
        it.copy(currentIndex = index.coerceIn(0, (count - 1).coerceAtLeast(0)))
    }

    fun next() = goTo(_uiState.value.currentIndex + 1)
    fun previous() = goTo(_uiState.value.currentIndex - 1)

    fun selectAnswer(questionId: Long, choiceId: Long) {
        _uiState.update { it.copy(selectedAnswers = it.selectedAnswers + (questionId to choiceId)) }
        viewModelScope.launch { submitAnswer(attemptId, questionId, choiceId) }
    }

    fun submit(onSubmitted: (Long) -> Unit) {
        viewModelScope.launch {
            _uiState.update { it.copy(isSubmitting = true, error = null) }
            when (val result = submitAttempt(attemptId)) {
                is AppResult.Success -> {
                    _uiState.update { it.copy(isSubmitting = false) }
                    onSubmitted(result.data.attemptId)
                }
                is AppResult.Failure -> _uiState.update { it.copy(isSubmitting = false, error = result.message) }
            }
        }
    }

    /** Toggles play/pause for one listening-question's audio, fetching its presigned URL on first play. */
    fun toggleAudio(audioId: Long) {
        if (loadedAudioId == audioId) {
            if (player.isPlaying) player.pause() else player.play()
            _uiState.update { it.copy(playingAudioId = audioId) }
            return
        }
        viewModelScope.launch {
            _uiState.update { it.copy(isAudioLoading = true, playingAudioId = audioId, error = null) }
            when (val result = getListeningAudio(audioId)) {
                is AppResult.Success -> {
                    loadedAudioId = audioId
                    player.setMediaItem(MediaItem.fromUri(result.data.audioUrl))
                    player.prepare()
                    player.play()
                    _uiState.update { it.copy(isAudioLoading = false) }
                }
                is AppResult.Failure -> _uiState.update {
                    it.copy(isAudioLoading = false, playingAudioId = null, error = result.message)
                }
            }
        }
    }

    override fun onCleared() {
        player.release()
        super.onCleared()
    }
}
