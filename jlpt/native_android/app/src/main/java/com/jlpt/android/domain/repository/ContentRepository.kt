package com.jlpt.android.domain.repository

import com.jlpt.android.domain.model.Grammar
import com.jlpt.android.domain.model.JlptLevel
import com.jlpt.android.domain.model.Kanji
import com.jlpt.android.domain.model.ListeningAudio
import com.jlpt.android.domain.model.Passage
import com.jlpt.android.domain.model.Vocabulary
import com.jlpt.android.domain.util.AppResult

interface ContentRepository {
    suspend fun getVocabulary(level: JlptLevel): AppResult<List<Vocabulary>>
    suspend fun getKanji(level: JlptLevel): AppResult<List<Kanji>>
    suspend fun getGrammar(level: JlptLevel): AppResult<List<Grammar>>
    suspend fun getPassage(id: Long): AppResult<Passage>
    suspend fun getListeningAudio(id: Long): AppResult<ListeningAudio>
}
