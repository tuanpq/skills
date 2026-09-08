import Foundation

protocol ContentRepository {
    func getVocabulary(level: JlptLevel) async -> AppResult<[Vocabulary]>
    func getKanji(level: JlptLevel) async -> AppResult<[Kanji]>
    func getGrammar(level: JlptLevel) async -> AppResult<[Grammar]>
    func getPassage(id: Int64) async -> AppResult<Passage>
    func getListeningAudio(id: Int64) async -> AppResult<ListeningAudio>
}
