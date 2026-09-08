package com.jlpt.android.presentation.exam.components

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.selection.selectable
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Pause
import androidx.compose.material.icons.filled.PlayArrow
import androidx.compose.material3.Card
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.RadioButton
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.jlpt.android.domain.model.ExamQuestion
import com.jlpt.android.domain.model.SkillType

@Composable
fun QuestionCard(
    question: ExamQuestion,
    questionNumber: Int,
    selectedChoiceId: Long?,
    onSelectChoice: (Long) -> Unit,
    isAudioPlaying: Boolean,
    isAudioLoading: Boolean,
    onToggleAudio: (Long) -> Unit,
    modifier: Modifier = Modifier
) {
    Column(modifier = modifier.verticalScroll(rememberScrollState()).padding(16.dp)) {
        Text("Câu $questionNumber", style = MaterialTheme.typography.labelLarge)

        if (question.skillType == SkillType.LISTENING && question.listeningAudioId != null) {
            Row(verticalAlignment = Alignment.CenterVertically, modifier = Modifier.padding(top = 8.dp)) {
                IconButton(onClick = { onToggleAudio(question.listeningAudioId) }) {
                    when {
                        isAudioLoading -> CircularProgressIndicator(modifier = Modifier.padding(4.dp))
                        isAudioPlaying -> Icon(Icons.Filled.Pause, contentDescription = "Pause")
                        else -> Icon(Icons.Filled.PlayArrow, contentDescription = "Play")
                    }
                }
                Text("Nghe đoạn hội thoại", style = MaterialTheme.typography.bodyLarge)
            }
        }

        question.passageContent?.let { passage ->
            Card(modifier = Modifier.fillMaxWidth().padding(top = 12.dp)) {
                Text(passage, modifier = Modifier.padding(16.dp), style = MaterialTheme.typography.bodyLarge)
            }
        }

        Text(
            question.questionText,
            style = MaterialTheme.typography.titleLarge,
            modifier = Modifier.padding(top = 16.dp)
        )

        Column(modifier = Modifier.padding(top = 12.dp), verticalArrangement = Arrangement.spacedBy(4.dp)) {
            question.choices.sortedBy { it.displayOrder }.forEach { choice ->
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .selectable(
                            selected = choice.id == selectedChoiceId,
                            onClick = { onSelectChoice(choice.id) }
                        )
                        .padding(vertical = 4.dp),
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    RadioButton(selected = choice.id == selectedChoiceId, onClick = { onSelectChoice(choice.id) })
                    Text(choice.choiceText, style = MaterialTheme.typography.bodyLarge, modifier = Modifier.padding(start = 8.dp))
                }
            }
        }
    }
}
