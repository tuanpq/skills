package com.jlpt.android.presentation.exam

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
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
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.jlpt.android.presentation.common.ErrorView
import com.jlpt.android.presentation.common.LoadingIndicator

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AttemptResultScreen(onBack: () -> Unit, viewModel: AttemptResultViewModel = hiltViewModel()) {
    val state by viewModel.uiState.collectAsState()

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Kết quả") },
                navigationIcon = {
                    IconButton(onClick = onBack) {
                        Icon(Icons.AutoMirrored.Filled.ArrowBack, contentDescription = "Back")
                    }
                }
            )
        }
    ) { padding ->
        when {
            state.isLoading -> LoadingIndicator(Modifier.fillMaxSize().padding(padding))
            state.error != null -> ErrorView(state.error!!, onRetry = viewModel::load, modifier = Modifier.fillMaxSize().padding(padding))
            state.result != null -> {
                val result = state.result!!
                Column(modifier = Modifier.fillMaxSize().padding(padding)) {
                    Card(modifier = Modifier.fillMaxWidth().padding(16.dp)) {
                        Column(modifier = Modifier.padding(20.dp)) {
                            Text("Điểm số", style = MaterialTheme.typography.labelLarge)
                            Text(
                                "${result.score ?: 0} / ${result.maxScore ?: 0}",
                                style = MaterialTheme.typography.headlineMedium
                            )
                        }
                    }

                    LazyColumn(
                        modifier = Modifier.fillMaxSize().padding(horizontal = 16.dp),
                        verticalArrangement = Arrangement.spacedBy(8.dp)
                    ) {
                        items(result.answers) { answer ->
                            val correct = answer.correct
                            Card(
                                colors = CardDefaults.cardColors(
                                    containerColor = if (correct) {
                                        MaterialTheme.colorScheme.primaryContainer
                                    } else {
                                        MaterialTheme.colorScheme.errorContainer
                                    }
                                )
                            ) {
                                Column(modifier = Modifier.padding(16.dp)) {
                                    Text(
                                        answer.questionText,
                                        fontWeight = FontWeight.Medium,
                                        style = MaterialTheme.typography.bodyLarge
                                    )
                                    Text(
                                        if (correct) "Chính xác" else "Chưa chính xác",
                                        style = MaterialTheme.typography.labelLarge
                                    )
                                    answer.explanation?.let {
                                        Text(it, style = MaterialTheme.typography.bodyLarge)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
