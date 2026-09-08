package com.jlpt.android.data.remote.dto

import com.jlpt.android.domain.model.JlptLevel
import kotlinx.serialization.Serializable

@Serializable
data class VocabularyResponseDto(
    val id: Long,
    val level: JlptLevel,
    val word: String,
    val reading: String,
    val meaningVi: String,
    val meaningEn: String? = null,
    val partOfSpeech: String? = null,
    val exampleSentence: String? = null,
    val exampleReading: String? = null,
    val exampleMeaning: String? = null
)

@Serializable
data class KanjiResponseDto(
    val id: Long,
    val level: JlptLevel,
    val character: String,
    val onyomi: String? = null,
    val kunyomi: String? = null,
    val meaningVi: String,
    val strokeCount: Int? = null,
    val exampleWords: String? = null
)

@Serializable
data class GrammarResponseDto(
    val id: Long,
    val level: JlptLevel,
    val pattern: String,
    val meaningVi: String,
    val meaningEn: String? = null,
    val usageNote: String? = null,
    val exampleSentence: String? = null,
    val exampleMeaning: String? = null
)

@Serializable
data class PassageResponseDto(
    val id: Long,
    val level: JlptLevel,
    val title: String,
    val content: String
)

@Serializable
data class ListeningAudioResponseDto(
    val id: Long,
    val level: JlptLevel,
    val title: String,
    val audioUrl: String,
    val transcript: String? = null,
    val durationSeconds: Int? = null
)

/** Mirrors the subset of Spring Data's `Page<T>` JSON shape we actually use. */
@Serializable
data class PageDto<T>(
    val content: List<T>,
    val totalElements: Long = 0,
    val totalPages: Int = 0,
    val number: Int = 0,
    val size: Int = 0
)
