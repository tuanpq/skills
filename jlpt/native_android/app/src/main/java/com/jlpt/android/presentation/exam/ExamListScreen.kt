package com.jlpt.android.presentation.exam

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.FilterChip
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.SegmentedButton
import androidx.compose.material3.SegmentedButtonDefaults
import androidx.compose.material3.SingleChoiceSegmentedButtonRow
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
import com.jlpt.android.domain.model.AttemptStatus
import com.jlpt.android.domain.model.SkillType
import com.jlpt.android.presentation.common.EmptyState
import com.jlpt.android.presentation.common.ErrorView
import com.jlpt.android.presentation.common.LevelDropdown
import com.jlpt.android.presentation.common.LoadingIndicator

@Composable
fun ExamListScreen(rootNavController: NavHostController, viewModel: ExamListViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsState()

    Column(modifier = Modifier.fillMaxSize().padding(16.dp)) {
        SingleChoiceSegmentedButtonRow(modifier = Modifier.fillMaxWidth()) {
            SegmentedButton(
                selected = !state.showHistory,
                onClick = { viewModel.toggleHistory(false) },
                shape = SegmentedButtonDefaults.itemShape(0, 2)
            ) { Text("Đề luyện thi") }
            SegmentedButton(
                selected = state.showHistory,
                onClick = { viewModel.toggleHistory(true) },
                shape = SegmentedButtonDefaults.itemShape(1, 2)
            ) { Text("Lịch sử") }
        }

        if (!state.showHistory) {
            Row(
                modifier = Modifier.fillMaxWidth().padding(vertical = 12.dp),
                horizontalArrangement = Arrangement.spacedBy(8.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                LevelDropdown(selected = state.level, onSelected = viewModel::selectLevel)
                FilterChip(
                    selected = state.skill == null,
                    onClick = { viewModel.selectSkill(null) },
                    label = { Text("Tất cả") }
                )
                SkillType.entries.forEach { skill ->
                    FilterChip(
                        selected = state.skill == skill,
                        onClick = { viewModel.selectSkill(skill) },
                        label = { Text(skill.name.take(4)) }
                    )
                }
            }
        }

        when {
            state.isLoading -> LoadingIndicator(Modifier.fillMaxSize())
            state.error != null -> ErrorView(state.error!!, onRetry = viewModel::load)
            state.showHistory && state.history.isEmpty() -> EmptyState("Chưa có lịch sử làm bài.")
            !state.showHistory && state.exams.isEmpty() -> EmptyState("Không có đề luyện thi cho lựa chọn này.")
            state.showHistory -> LazyColumn(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                items(state.history) { attempt ->
                    Card(modifier = Modifier.fillMaxWidth()) {
                        Column(modifier = Modifier.fillMaxWidth().padding(16.dp)) {
                            Text(attempt.examTitle, style = MaterialTheme.typography.titleLarge)
                            Text(
                                if (attempt.status == AttemptStatus.SUBMITTED) {
                                    "Điểm: ${attempt.score ?: 0}/${attempt.maxScore ?: 0}"
                                } else {
                                    "Đang làm dở"
                                },
                                style = MaterialTheme.typography.bodyLarge
                            )
                            Button(
                                onClick = {
                                    val destination = if (attempt.status == AttemptStatus.SUBMITTED) {
                                        Routes.attemptResult(attempt.id)
                                    } else {
                                        Routes.examAttempt(attempt.id)
                                    }
                                    rootNavController.navigate(destination)
                                },
                                modifier = Modifier.padding(top = 8.dp)
                            ) {
                                Text(if (attempt.status == AttemptStatus.SUBMITTED) "Xem kết quả" else "Tiếp tục")
                            }
                        }
                    }
                }
            }
            else -> LazyColumn(verticalArrangement = Arrangement.spacedBy(8.dp)) {
                items(state.exams) { exam ->
                    Card(modifier = Modifier.fillMaxWidth()) {
                        Column(modifier = Modifier.fillMaxWidth().padding(16.dp)) {
                            Text(exam.title, style = MaterialTheme.typography.titleLarge)
                            Text(
                                "${exam.examType.name} · ${exam.questionCount} câu · ${exam.timeLimitMinutes} phút",
                                style = MaterialTheme.typography.bodyLarge
                            )
                            Button(
                                onClick = {
                                    viewModel.startAttempt(exam.id) { attemptId ->
                                        rootNavController.navigate(Routes.examAttempt(attemptId))
                                    }
                                },
                                enabled = !state.isStarting,
                                modifier = Modifier.padding(top = 8.dp)
                            ) {
                                Text("Bắt đầu")
                            }
                        }
                    }
                }
            }
        }
    }
}
