package com.jlpt.android.presentation.study.components

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.animation.core.tween
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.graphicsLayer
import androidx.compose.ui.unit.dp

/** A tappable card that flips between [front] (word/kanji/pattern) and [back] (meaning/details). */
@Composable
fun Flashcard(
    isFlipped: Boolean,
    onClick: () -> Unit,
    modifier: Modifier = Modifier,
    front: @Composable () -> Unit,
    back: @Composable () -> Unit
) {
    val rotation by animateFloatAsState(targetValue = if (isFlipped) 180f else 0f, animationSpec = tween(350), label = "flip")

    Card(
        modifier = modifier
            .fillMaxSize()
            .clickable(onClick = onClick)
            .graphicsLayer {
                rotationY = rotation
                cameraDistance = 12f * density
            },
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp)
    ) {
        Box(modifier = Modifier.fillMaxSize().padding(24.dp), contentAlignment = Alignment.Center) {
            if (rotation <= 90f) {
                front()
            } else {
                Box(modifier = Modifier.graphicsLayer { rotationY = 180f }) {
                    back()
                }
            }
        }
    }
}
