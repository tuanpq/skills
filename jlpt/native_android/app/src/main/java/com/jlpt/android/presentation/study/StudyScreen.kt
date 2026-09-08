package com.jlpt.android.presentation.study

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ChevronLeft
import androidx.compose.material.icons.filled.ChevronRight
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.PrimaryTabRow
import androidx.compose.material3.Tab
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController
import com.jlpt.android.core.navigation.Routes
import com.jlpt.android.domain.model.StudyItemType
import com.jlpt.android.domain.model.StudyStatus
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

private val tabTypes = listOf(StudyItemType.VOCABULARY, StudyItemType.KANJI, StudyItemType.GRAMMAR)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun StudyScreen(rootNavController: NavHostController, viewModel: StudyViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsState()
    val selectedTabIndex = tabTypes.indexOf(state.type).coerceAtLeast(0)

    Column(modifier = Modifier.fillMaxSize()) {
        PrimaryTabRow(selectedTabIndex = selectedTabIndex) {
            tabTypes.forEachIndexed { index, type ->
                Tab(
                    selected = index == selectedTabIndex,
                    onClick = { viewModel.selectType(type) },
                    text = { Text(type.name) }
                )
            }
        }

        Row(
            modifier = Modifier.fillMaxWidth().padding(16.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            LevelDropdown(selected = state.level, onSelected = viewModel::selectLevel)
            OutlinedButton(onClick = { rootNavController.navigate(Routes.review(state.type.name.lowercase())) }) {
                Text("Ôn tập SRS")
            }
        }

        when {
            state.isLoading && state.currentCount == 0 -> LoadingIndicator(Modifier.weight(1f))
            state.error != null && state.currentCount == 0 -> ErrorView(state.error!!, onRetry = viewModel::load, modifier = Modifier.weight(1f))
            state.currentCount == 0 -> EmptyState("Không có dữ liệu cho cấp độ này.", Modifier.weight(1f))
            else -> Column(modifier = Modifier.weight(1f).padding(16.dp), verticalArrangement = Arrangement.SpaceBetween) {
                Row(
                    modifier = Modifier.weight(1f).fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    IconButton(onClick = viewModel::previous) {
                        Icon(Icons.Filled.ChevronLeft, contentDescription = "Previous")
                    }

                    Flashcard(
                        isFlipped = state.isFlipped,
                        onClick = viewModel::flip,
                        modifier = Modifier.weight(1f).aspectRatio(1.2f),
                        front = {
                            when (state.type) {
                                StudyItemType.VOCABULARY -> VocabularyFront(state.vocabItems[state.currentIndex].item)
                                StudyItemType.KANJI -> KanjiFront(state.kanjiItems[state.currentIndex].item)
                                StudyItemType.GRAMMAR -> GrammarFront(state.grammarItems[state.currentIndex].item)
                            }
                        },
                        back = {
                            when (state.type) {
                                StudyItemType.VOCABULARY -> VocabularyBack(state.vocabItems[state.currentIndex].item)
                                StudyItemType.KANJI -> KanjiBack(state.kanjiItems[state.currentIndex].item)
                                StudyItemType.GRAMMAR -> GrammarBack(state.grammarItems[state.currentIndex].item)
                            }
                        }
                    )

                    IconButton(onClick = viewModel::next) {
                        Icon(Icons.Filled.ChevronRight, contentDescription = "Next")
                    }
                }

                Text(
                    "${state.currentIndex + 1} / ${state.currentCount}",
                    style = MaterialTheme.typography.labelLarge,
                    modifier = Modifier.padding(top = 8.dp)
                )

                Row(
                    modifier = Modifier.fillMaxWidth().padding(top = 12.dp),
                    horizontalArrangement = Arrangement.spacedBy(8.dp)
                ) {
                    OutlinedButton(onClick = { viewModel.markStatus(StudyStatus.NEW) }, modifier = Modifier.weight(1f)) {
                        Text("Mới")
                    }
                    OutlinedButton(onClick = { viewModel.markStatus(StudyStatus.LEARNING) }, modifier = Modifier.weight(1f)) {
                        Text("Đang học")
                    }
                    OutlinedButton(onClick = { viewModel.markStatus(StudyStatus.MASTERED) }, modifier = Modifier.weight(1f)) {
                        Text("Đã thuộc")
                    }
                }
            }
        }
    }
}
