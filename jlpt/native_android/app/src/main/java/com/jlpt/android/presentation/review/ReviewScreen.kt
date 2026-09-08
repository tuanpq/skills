package com.jlpt.android.presentation.review

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material3.Button
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.jlpt.android.domain.model.ReviewQuality
import com.jlpt.android.domain.model.StudyItemType
import com.jlpt.android.presentation.common.EmptyState
import com.jlpt.android.presentation.common.ErrorView
import com.jlpt.android.presentation.common.LevelDropdown
import com.jlpt.android.presentation.common.LoadingIndicator
import com.jlpt.android.presentation.study.components.Flashcard
import com.jlpt.android.presentation.study.components.GrammarBack
import com.jlpt.android.presentation.study.components.GrammarFront
import com.jlpt.android.presentation.study.components.KanjiBack
import com.jlpt.android.presentation.study.components.KanjiFront
import com.jlpt.android.presentation.study.components.VocabularyBack
import com.jlpt.android.presentation.study.components.VocabularyFront

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ReviewScreen(onBack: () -> Unit, viewModel: ReviewViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsState()

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Ôn tập SRS – ${state.itemType.name}") },
                navigationIcon = {
                    IconButton(onClick = onBack) {
                        Icon(Icons.AutoMirrored.Filled.ArrowBack, contentDescription = "Back")
                    }
                }
            )
        }
    ) { padding ->
        Column(modifier = Modifier.fillMaxSize().padding(padding).padding(16.dp)) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                LevelDropdown(selected = state.level, onSelected = viewModel::selectLevel)
                Text("Còn lại: ${state.remaining}", style = MaterialTheme.typography.labelLarge)
            }

            when {
                state.isLoading -> LoadingIndicator(Modifier.weight(1f))
                state.error != null -> ErrorView(state.error!!, onRetry = viewModel::load, modifier = Modifier.weight(1f))
                state.finished -> EmptyState("🎉 Không còn thẻ nào đến hạn ôn tập!", Modifier.weight(1f))
                else -> Column(modifier = Modifier.weight(1f).padding(top = 16.dp), verticalArrangement = Arrangement.SpaceBetween) {
                    Flashcard(
                        isFlipped = state.isFlipped,
                        onClick = viewModel::flip,
                        modifier = Modifier.weight(1f).fillMaxWidth().aspectRatio(1.1f),
                        front = {
                            when (state.itemType) {
                                StudyItemType.VOCABULARY -> VocabularyFront(state.vocabQueue.first().item)
                                StudyItemType.KANJI -> KanjiFront(state.kanjiQueue.first().item)
                                StudyItemType.GRAMMAR -> GrammarFront(state.grammarQueue.first().item)
                            }
                        },
                        back = {
                            when (state.itemType) {
                                StudyItemType.VOCABULARY -> VocabularyBack(state.vocabQueue.first().item)
                                StudyItemType.KANJI -> KanjiBack(state.kanjiQueue.first().item)
                                StudyItemType.GRAMMAR -> GrammarBack(state.grammarQueue.first().item)
                            }
                        }
                    )

                    if (state.isFlipped) {
                        Row(
                            modifier = Modifier.fillMaxWidth().padding(top = 16.dp),
                            horizontalArrangement = Arrangement.spacedBy(8.dp)
                        ) {
                            Button(onClick = { viewModel.rate(ReviewQuality.AGAIN) }, modifier = Modifier.weight(1f)) {
                                Text("Lại")
                            }
                            Button(onClick = { viewModel.rate(ReviewQuality.HARD) }, modifier = Modifier.weight(1f)) {
                                Text("Khó")
                            }
                            Button(onClick = { viewModel.rate(ReviewQuality.GOOD) }, modifier = Modifier.weight(1f)) {
                                Text("Tốt")
                            }
                            Button(onClick = { viewModel.rate(ReviewQuality.EASY) }, modifier = Modifier.weight(1f)) {
                                Text("Dễ")
                            }
                        }
                    } else {
                        Text(
                            "Chạm vào thẻ để xem đáp án",
                            style = MaterialTheme.typography.labelLarge,
                            modifier = Modifier.padding(top = 16.dp)
                        )
                    }
                }
            }
        }
    }
}
