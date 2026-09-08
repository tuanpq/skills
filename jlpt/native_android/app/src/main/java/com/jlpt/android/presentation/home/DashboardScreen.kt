package com.jlpt.android.presentation.home

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Card
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.jlpt.android.domain.model.StudyItemType
import com.jlpt.android.domain.model.StudyStatus
import com.jlpt.android.presentation.common.ErrorView
import com.jlpt.android.presentation.common.LoadingIndicator

@Composable
fun DashboardScreen(viewModel: DashboardViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsState()

    when {
        state.isLoading && state.progress == null -> LoadingIndicator()
        state.error != null && state.progress == null -> ErrorView(state.error!!, onRetry = viewModel::load)
        else -> Column(
            modifier = Modifier.fillMaxSize().padding(20.dp),
            verticalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            Text(
                "Xin chào, ${state.session?.displayName ?: ""}",
                style = MaterialTheme.typography.headlineMedium
            )
            Text(
                "Mục tiêu: ${state.session?.role?.name ?: ""}",
                style = MaterialTheme.typography.bodyLarge
            )

            val progress = state.progress
            if (progress != null) {
                StudyItemType.entries.forEach { type ->
                    Card(modifier = Modifier.fillMaxWidth()) {
                        Column(modifier = Modifier.padding(16.dp)) {
                            Text(type.name, style = MaterialTheme.typography.titleLarge)
                            Text(
                                "Mới: ${progress.countFor(type, StudyStatus.NEW)} · " +
                                    "Đang học: ${progress.countFor(type, StudyStatus.LEARNING)} · " +
                                    "Đã thuộc: ${progress.countFor(type, StudyStatus.MASTERED)}",
                                style = MaterialTheme.typography.bodyLarge
                            )
                        }
                    }
                }
            }
        }
    }
}
