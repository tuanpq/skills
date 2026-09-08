package com.jlpt.android.core.ui.theme

import android.os.Build
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.dynamicDarkColorScheme
import androidx.compose.material3.dynamicLightColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.platform.LocalContext

private val LightColors = lightColorScheme(
    primary = JlptRed,
    onPrimary = JlptCream,
    primaryContainer = JlptRedContainer,
    onPrimaryContainer = JlptRedDark,
    surface = JlptCream,
    onSurface = JlptOnSurface,
    outline = JlptOutline
)

private val DarkColors = darkColorScheme(
    primary = JlptRedDarkTheme,
    onPrimary = JlptRedDark,
    surface = JlptSurfaceDark,
    onSurface = JlptCream
)

@Composable
fun JlptTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    dynamicColor: Boolean = true,
    content: @Composable () -> Unit
) {
    val colorScheme = when {
        dynamicColor && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S -> {
            val context = LocalContext.current
            if (darkTheme) dynamicDarkColorScheme(context) else dynamicLightColorScheme(context)
        }
        darkTheme -> DarkColors
        else -> LightColors
    }

    MaterialTheme(
        colorScheme = colorScheme,
        typography = JlptTypography,
        content = content
    )
}
