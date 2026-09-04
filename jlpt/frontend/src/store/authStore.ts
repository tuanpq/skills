import { create } from 'zustand'
import { persist } from 'zustand/middleware'
import type { AuthResponse, JlptLevel, User } from '../types'

interface AuthState {
  accessToken: string | null
  refreshToken: string | null
  user: User | null
  selectedLevel: JlptLevel
  setAuth: (auth: AuthResponse) => void
  clearAuth: () => void
  setSelectedLevel: (level: JlptLevel) => void
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set) => ({
      accessToken: null,
      refreshToken: null,
      user: null,
      selectedLevel: 'N5',
      setAuth: (auth) =>
        set({
          accessToken: auth.accessToken,
          refreshToken: auth.refreshToken,
          user: {
            userId: auth.userId,
            email: auth.email,
            displayName: auth.displayName,
            role: auth.role,
          },
        }),
      clearAuth: () => set({ accessToken: null, refreshToken: null, user: null }),
      setSelectedLevel: (level) => set({ selectedLevel: level }),
    }),
    { name: 'jlpt-auth' },
  ),
)
