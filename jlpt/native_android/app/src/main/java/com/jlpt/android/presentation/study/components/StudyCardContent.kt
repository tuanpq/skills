package com.jlpt.android.presentation.study.components

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.jlpt.android.domain.model.Grammar
import com.jlpt.android.domain.model.Kanji
import com.jlpt.android.domain.model.Vocabulary

@Composable
fun VocabularyFront(item: Vocabulary) {
    Column(horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(8.dp)) {
        Text(item.word, fontSize = 40.sp, textAlign = TextAlign.Center)
        Text(item.reading, style = MaterialTheme.typography.titleLarge, textAlign = TextAlign.Center)
    }
}

@Composable
fun VocabularyBack(item: Vocabulary) {
    Column(horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(8.dp)) {
        Text(item.meaningVi, style = MaterialTheme.typography.titleLarge, textAlign = TextAlign.Center)
        item.partOfSpeech?.let { Text(it, style = MaterialTheme.typography.labelLarge) }
        item.exampleSentence?.let {
            Text(it, textAlign = TextAlign.Center, style = MaterialTheme.typography.bodyLarge)
        }
        item.exampleMeaning?.let {
            Text(it, textAlign = TextAlign.Center, style = MaterialTheme.typography.bodyLarge)
        }
    }
}

@Composable
fun KanjiFront(item: Kanji) {
    Text(item.character, fontSize = 72.sp, textAlign = TextAlign.Center)
}

@Composable
fun KanjiBack(item: Kanji) {
    Column(horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(8.dp)) {
        Text(item.meaningVi, style = MaterialTheme.typography.titleLarge, textAlign = TextAlign.Center)
        item.onyomi?.let { Text("Onyomi: $it", style = MaterialTheme.typography.bodyLarge) }
        item.kunyomi?.let { Text("Kunyomi: $it", style = MaterialTheme.typography.bodyLarge) }
        item.exampleWords?.let { Text(it, textAlign = TextAlign.Center, style = MaterialTheme.typography.bodyLarge) }
    }
}

@Composable
fun GrammarFront(item: Grammar) {
    Text(item.pattern, style = MaterialTheme.typography.headlineMedium, textAlign = TextAlign.Center)
}

@Composable
fun GrammarBack(item: Grammar) {
    Column(horizontalAlignment = Alignment.CenterHorizontally, verticalArrangement = Arrangement.spacedBy(8.dp)) {
        Text(item.meaningVi, style = MaterialTheme.typography.titleLarge, textAlign = TextAlign.Center)
        item.usageNote?.let { Text(it, textAlign = TextAlign.Center, style = MaterialTheme.typography.bodyLarge) }
        item.exampleSentence?.let { Text(it, textAlign = TextAlign.Center, style = MaterialTheme.typography.bodyLarge) }
        item.exampleMeaning?.let { Text(it, textAlign = TextAlign.Center, style = MaterialTheme.typography.bodyLarge) }
    }
}
