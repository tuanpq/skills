import { apiClient } from './client'
import type { ApiPage, GrammarPoint, JlptLevel, KanjiItem, ListeningAudio, VocabularyItem } from '../types'

const PAGE_SIZE = 50

export async function fetchVocabulary(level: JlptLevel): Promise<VocabularyItem[]> {
  const { data } = await apiClient.get<ApiPage<VocabularyItem>>('/api/vocabulary', {
    params: { level, size: PAGE_SIZE },
  })
  return data.content
}

export async function fetchKanji(level: JlptLevel): Promise<KanjiItem[]> {
  const { data } = await apiClient.get<ApiPage<KanjiItem>>('/api/kanji', {
    params: { level, size: PAGE_SIZE },
  })
  return data.content
}

export async function fetchGrammar(level: JlptLevel): Promise<GrammarPoint[]> {
  const { data } = await apiClient.get<ApiPage<GrammarPoint>>('/api/grammar', {
    params: { level, size: PAGE_SIZE },
  })
  return data.content
}

export async function fetchListeningAudio(id: number): Promise<ListeningAudio> {
  const { data } = await apiClient.get<ListeningAudio>(`/api/listening-audios/${id}`)
  return data
}
