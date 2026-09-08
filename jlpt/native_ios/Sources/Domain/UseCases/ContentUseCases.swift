import Foundation

struct GetVocabularyUseCase {
    let repository: ContentRepository
    func callAsFunction(level: JlptLevel) async -> AppResult<[Vocabulary]> { await repository.getVocabulary(level: level) }
}

struct GetKanjiUseCase {
    let repository: ContentRepository
    func callAsFunction(level: JlptLevel) async -> AppResult<[Kanji]> { await repository.getKanji(level: level) }
}

struct GetGrammarUseCase {
    let repository: ContentRepository
    func callAsFunction(level: JlptLevel) async -> AppResult<[Grammar]> { await repository.getGrammar(level: level) }
}

struct GetPassageUseCase {
    let repository: ContentRepository
    func callAsFunction(id: Int64) async -> AppResult<Passage> { await repository.getPassage(id: id) }
}

struct GetListeningAudioUseCase {
    let repository: ContentRepository
    func callAsFunction(id: Int64) async -> AppResult<ListeningAudio> { await repository.getListeningAudio(id: id) }
}
