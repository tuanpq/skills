import { apiClient } from './client'
import type { Attempt, AttemptResult, ExamSummary, JlptLevel, SkillType } from '../types'

export async function fetchExams(level: JlptLevel, skill?: SkillType): Promise<ExamSummary[]> {
  const { data } = await apiClient.get<ExamSummary[]>('/api/exams', { params: { level, skill } })
  return data
}

export async function startAttempt(examId: number): Promise<Attempt> {
  const { data } = await apiClient.post<Attempt>(`/api/exams/${examId}/attempts`)
  return data
}

export async function fetchAttempt(attemptId: number): Promise<Attempt> {
  const { data } = await apiClient.get<Attempt>(`/api/attempts/${attemptId}`)
  return data
}

export async function submitAnswer(
  attemptId: number,
  questionId: number,
  selectedChoiceId: number | null,
): Promise<void> {
  await apiClient.put(`/api/attempts/${attemptId}/answers`, { questionId, selectedChoiceId })
}

export async function submitAttempt(attemptId: number): Promise<AttemptResult> {
  const { data } = await apiClient.post<AttemptResult>(`/api/attempts/${attemptId}/submit`)
  return data
}

export async function fetchAttemptResult(attemptId: number): Promise<AttemptResult> {
  const { data } = await apiClient.get<AttemptResult>(`/api/attempts/${attemptId}/result`)
  return data
}

export async function fetchMyAttempts(): Promise<Attempt[]> {
  const { data } = await apiClient.get<Attempt[]>('/api/users/me/attempts')
  return data
}
