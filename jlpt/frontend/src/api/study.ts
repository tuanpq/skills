import { apiClient } from './client'
import type {
  GrammarStudy,
  JlptLevel,
  KanjiStudy,
  ProgressSummary,
  ReviewResult,
  StudyItemType,
  StudyStatus,
  VocabularyStudy,
} from '../types'

const PAGE_SIZE = 50

export async function fetchVocabularyStudy(level: JlptLevel): Promise<VocabularyStudy[]> {
  const { data } = await apiClient.get<VocabularyStudy[]>('/api/study/vocabulary', {
    params: { level, size: PAGE_SIZE },
  })
  return data
}

export async function fetchKanjiStudy(level: JlptLevel): Promise<KanjiStudy[]> {
  const { data } = await apiClient.get<KanjiStudy[]>('/api/study/kanji', {
    params: { level, size: PAGE_SIZE },
  })
  return data
}

export async function fetchGrammarStudy(level: JlptLevel): Promise<GrammarStudy[]> {
  const { data } = await apiClient.get<GrammarStudy[]>('/api/study/grammar', {
    params: { level, size: PAGE_SIZE },
  })
  return data
}

export async function updateProgress(
  itemType: StudyItemType,
  itemId: number,
  status: StudyStatus,
): Promise<void> {
  await apiClient.post('/api/study/progress', { itemType, itemId, status })
}

export async function fetchMyProgress(): Promise<ProgressSummary> {
  const { data } = await apiClient.get<ProgressSummary>('/api/users/me/progress')
  return data
}

export async function fetchVocabularyDue(level: JlptLevel): Promise<VocabularyStudy[]> {
  const { data } = await apiClient.get<VocabularyStudy[]>('/api/study/vocabulary/due', {
    params: { level, size: PAGE_SIZE },
  })
  return data
}

export async function fetchKanjiDue(level: JlptLevel): Promise<KanjiStudy[]> {
  const { data } = await apiClient.get<KanjiStudy[]>('/api/study/kanji/due', {
    params: { level, size: PAGE_SIZE },
  })
  return data
}

export async function fetchGrammarDue(level: JlptLevel): Promise<GrammarStudy[]> {
  const { data } = await apiClient.get<GrammarStudy[]>('/api/study/grammar/due', {
    params: { level, size: PAGE_SIZE },
  })
  return data
}

export async function submitReview(
  itemType: StudyItemType,
  itemId: number,
  quality: number,
): Promise<ReviewResult> {
  const { data } = await apiClient.post<ReviewResult>('/api/study/review', { itemType, itemId, quality })
  return data
}
