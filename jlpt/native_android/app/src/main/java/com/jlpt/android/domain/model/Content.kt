package com.jlpt.android.domain.model

data class Vocabulary(
    val id: Long,
    val level: JlptLevel,
    val word: String,
    val reading: String,
    val meaningVi: String,
    val meaningEn: String?,
    val partOfSpeech: String?,
    val exampleSentence: String?,
    val exampleReading: String?,
    val exampleMeaning: String?
)

data class Kanji(
    val id: Long,
    val level: JlptLevel,
    val character: String,
    val onyomi: String?,
    val kunyomi: String?,
    val meaningVi: String,
    val strokeCount: Int?,
    val exampleWords: String?
)

data class Grammar(
    val id: Long,
    val level: JlptLevel,
    val pattern: String,
    val meaningVi: String,
    val meaningEn: String?,
    val usageNote: String?,
    val exampleSentence: String?,
    val exampleMeaning: String?
)

data class Passage(
    val id: Long,
    val level: JlptLevel,
    val title: String,
    val content: String
)

data class ListeningAudio(
    val id: Long,
    val level: JlptLevel,
    val title: String,
    val audioUrl: String,
    val transcript: String?,
    val durationSeconds: Int?
)
