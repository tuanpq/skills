package com.jlpt.android.presentation.exam

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Button
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.jlpt.android.presentation.common.ErrorView
import com.jlpt.android.presentation.common.LoadingIndicator
import com.jlpt.android.presentation.exam.components.QuestionCard

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ExamAttemptScreen(onSubmitted: (Long) -> Unit, viewModel: ExamAttemptViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsState()

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(state.attempt?.examTitle ?: "Làm bài") },
                actions = {
                    state.remainingSeconds?.let { seconds ->
                        val minutes = seconds / 60
                        val secs = seconds % 60
                        Text(
                            "%02d:%02d".format(minutes, secs),
                            style = MaterialTheme.typography.titleLarge,
                            modifier = Modifier.padding(end = 16.dp)
                        )
                    }
                }
            )
        }
    ) { padding ->
        when {
            state.isLoading -> LoadingIndicator(Modifier.fillMaxSize().padding(padding))
            state.error != null && state.attempt == null -> ErrorView(
                state.error!!,
                onRetry = viewModel::load,
                modifier = Modifier.fillMaxSize().padding(padding)
            )
            state.attempt != null -> {
                val attempt = state.attempt!!
                val question = attempt.questions.getOrNull(state.currentIndex)
                Column(modifier = Modifier.fillMaxSize().padding(padding)) {
                    if (question != null) {
                        QuestionCard(
                            question = question,
                            questionNumber = state.currentIndex + 1,
                            selectedChoiceId = state.selectedAnswers[question.id],
                            onSelectChoice = { choiceId -> viewModel.selectAnswer(question.id, choiceId) },
                            isAudioPlaying = state.isAudioPlaying && state.playingAudioId == question.listeningAudioId,
                            isAudioLoading = state.isAudioLoading && state.playingAudioId == question.listeningAudioId,
                            onToggleAudio = viewModel::toggleAudio,
                            modifier = Modifier.weight(1f)
                        )
                    }

                    Row(
                        modifier = Modifier.fillMaxWidth().padding(16.dp),
                        horizontalArrangement = Arrangement.SpaceBetween
                    ) {
                        OutlinedButton(onClick = viewModel::previous, enabled = state.currentIndex > 0) {
                            Text("Trước")
                        }
                        Text(
                            "${state.currentIndex + 1} / ${attempt.questions.size}",
                            style = MaterialTheme.typography.labelLarge
                        )
                        if (state.currentIndex < attempt.questions.size - 1) {
                            OutlinedButton(onClick = viewModel::next) { Text("Tiếp") }
                        } else {
                            Button(
                                onClick = { viewModel.submit(onSubmitted) },
                                enabled = !state.isSubmitting
                            ) {
                                if (state.isSubmitting) {
                                    CircularProgressIndicator(modifier = Modifier.padding(2.dp))
                                } else {
                                    Text("Nộp bài")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
