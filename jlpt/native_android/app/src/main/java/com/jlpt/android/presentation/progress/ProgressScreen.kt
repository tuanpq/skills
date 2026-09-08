package com.jlpt.android.presentation.progress

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Card
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavHostController
import com.jlpt.android.domain.model.StudyItemType
import com.jlpt.android.domain.model.StudyStatus
import com.jlpt.android.presentation.common.ErrorView
import com.jlpt.android.presentation.common.LoadingIndicator

@Composable
fun ProgressScreen(rootNavController: NavHostController, viewModel: ProgressViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsState()

    when {
        state.isLoading -> LoadingIndicator(Modifier.fillMaxSize())
        state.error != null -> ErrorView(state.error!!, onRetry = viewModel::load)
        else -> Column(
            modifier = Modifier.fillMaxSize().padding(20.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            Text("Tiến độ học tập", style = MaterialTheme.typography.headlineMedium)

            val summary = state.summary
            if (summary != null) {
                StudyItemType.entries.forEach { type ->
                    val total = summary.totalFor(type).coerceAtLeast(1)
                    val mastered = summary.countFor(type, StudyStatus.MASTERED)
                    Card(modifier = Modifier.fillMaxWidth()) {
                        Column(modifier = Modifier.padding(16.dp)) {
                            Text(type.name, style = MaterialTheme.typography.titleLarge)
                            LinearProgressIndicator(
                                progress = { (mastered.toFloat() / total.toFloat()).coerceIn(0f, 1f) },
                                modifier = Modifier.fillMaxWidth().padding(top = 8.dp)
                            )
                            Text(
                                "Đã thuộc $mastered / ${summary.totalFor(type)}",
                                style = MaterialTheme.typography.bodyLarge,
                                modifier = Modifier.padding(top = 4.dp)
                            )
                        }
                    }
                }
            }

            OutlinedButton(onClick = viewModel::logout, modifier = Modifier.fillMaxWidth()) {
                Text("Đăng xuất")
            }
        }
    }
}
