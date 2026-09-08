package com.jlpt.android.data.mapper

import com.jlpt.android.data.remote.dto.GrammarResponseDto
import com.jlpt.android.data.remote.dto.KanjiResponseDto
import com.jlpt.android.data.remote.dto.ListeningAudioResponseDto
import com.jlpt.android.data.remote.dto.PassageResponseDto
import com.jlpt.android.data.remote.dto.VocabularyResponseDto
import com.jlpt.android.domain.model.Grammar
import com.jlpt.android.domain.model.Kanji
import com.jlpt.android.domain.model.ListeningAudio
import com.jlpt.android.domain.model.Passage
import com.jlpt.android.domain.model.Vocabulary

fun VocabularyResponseDto.toDomain() = Vocabulary(
    id = id,
    level = level,
    word = word,
    reading = reading,
    meaningVi = meaningVi,
    meaningEn = meaningEn,
    partOfSpeech = partOfSpeech,
    exampleSentence = exampleSentence,
    exampleReading = exampleReading,
    exampleMeaning = exampleMeaning
)

fun KanjiResponseDto.toDomain() = Kanji(
    id = id,
    level = level,
    character = character,
    onyomi = onyomi,
    kunyomi = kunyomi,
    meaningVi = meaningVi,
    strokeCount = strokeCount,
    exampleWords = exampleWords
)

fun GrammarResponseDto.toDomain() = Grammar(
    id = id,
    level = level,
    pattern = pattern,
    meaningVi = meaningVi,
    meaningEn = meaningEn,
    usageNote = usageNote,
    exampleSentence = exampleSentence,
    exampleMeaning = exampleMeaning
)

fun PassageResponseDto.toDomain() = Passage(id = id, level = level, title = title, content = content)

fun ListeningAudioResponseDto.toDomain() = ListeningAudio(
    id = id,
    level = level,
    title = title,
    audioUrl = audioUrl,
    transcript = transcript,
    durationSeconds = durationSeconds
)
