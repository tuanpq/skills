package com.jlpt.android.domain.usecase.content

import com.jlpt.android.domain.model.Grammar
import com.jlpt.android.domain.model.JlptLevel
import com.jlpt.android.domain.model.Kanji
import com.jlpt.android.domain.model.ListeningAudio
import com.jlpt.android.domain.model.Passage
import com.jlpt.android.domain.model.Vocabulary
import com.jlpt.android.domain.repository.ContentRepository
import com.jlpt.android.domain.util.AppResult
import javax.inject.Inject

class GetVocabularyUseCase @Inject constructor(private val repository: ContentRepository) {
    suspend operator fun invoke(level: JlptLevel): AppResult<List<Vocabulary>> = repository.getVocabulary(level)
}

class GetKanjiUseCase @Inject constructor(private val repository: ContentRepository) {
    suspend operator fun invoke(level: JlptLevel): AppResult<List<Kanji>> = repository.getKanji(level)
}

class GetGrammarUseCase @Inject constructor(private val repository: ContentRepository) {
    suspend operator fun invoke(level: JlptLevel): AppResult<List<Grammar>> = repository.getGrammar(level)
}

class GetPassageUseCase @Inject constructor(private val repository: ContentRepository) {
    suspend operator fun invoke(id: Long): AppResult<Passage> = repository.getPassage(id)
}

class GetListeningAudioUseCase @Inject constructor(private val repository: ContentRepository) {
    suspend operator fun invoke(id: Long): AppResult<ListeningAudio> = repository.getListeningAudio(id)
}
