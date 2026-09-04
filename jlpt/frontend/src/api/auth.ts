import { apiClient } from './client'
import type { AuthResponse, JlptLevel } from '../types'

export interface RegisterPayload {
  email: string
  password: string
  displayName: string
  targetLevel?: JlptLevel
}

export interface LoginPayload {
  email: string
  password: string
}

export async function register(payload: RegisterPayload): Promise<AuthResponse> {
  const { data } = await apiClient.post<AuthResponse>('/api/auth/register', payload)
  return data
}

export async function login(payload: LoginPayload): Promise<AuthResponse> {
  const { data } = await apiClient.post<AuthResponse>('/api/auth/login', payload)
  return data
}
