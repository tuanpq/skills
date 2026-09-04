import { useState, type FormEvent } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { useMutation } from '@tanstack/react-query'
import { isAxiosError } from 'axios'
import { register } from '../api/auth'
import { useAuthStore } from '../store/authStore'
import type { ApiError, JlptLevel } from '../types'

const LEVELS: JlptLevel[] = ['N5', 'N4', 'N3', 'N2', 'N1']

export function RegisterPage() {
  const navigate = useNavigate()
  const setAuth = useAuthStore((state) => state.setAuth)
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [displayName, setDisplayName] = useState('')
  const [targetLevel, setTargetLevel] = useState<JlptLevel>('N5')

  const mutation = useMutation({
    mutationFn: () => register({ email, password, displayName, targetLevel }),
    onSuccess: (data) => {
      setAuth(data)
      navigate('/')
    },
  })

  function handleSubmit(e: FormEvent) {
    e.preventDefault()
    mutation.mutate()
  }

  const errorMessage = isAxiosError<ApiError>(mutation.error)
    ? mutation.error.response?.data?.message
    : mutation.error && 'Đăng ký thất bại. Vui lòng thử lại.'

  return (
    <div className="flex min-h-screen items-center justify-center bg-slate-50 px-4">
      <div className="w-full max-w-sm rounded-lg border border-slate-200 bg-white p-6 shadow-sm">
        <h1 className="mb-1 text-xl font-bold text-slate-800">Đăng ký</h1>
        <p className="mb-5 text-sm text-slate-500">Tạo tài khoản để bắt đầu học JLPT</p>

        <form onSubmit={handleSubmit} className="flex flex-col gap-3">
          <label className="flex flex-col gap-1 text-sm">
            <span className="font-medium text-slate-700">Tên hiển thị</span>
            <input
              required
              value={displayName}
              onChange={(e) => setDisplayName(e.target.value)}
              className="rounded-md border border-slate-300 px-3 py-2 focus:border-indigo-500 focus:outline-none"
            />
          </label>
          <label className="flex flex-col gap-1 text-sm">
            <span className="font-medium text-slate-700">Email</span>
            <input
              type="email"
              required
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="rounded-md border border-slate-300 px-3 py-2 focus:border-indigo-500 focus:outline-none"
            />
          </label>
          <label className="flex flex-col gap-1 text-sm">
            <span className="font-medium text-slate-700">Mật khẩu (tối thiểu 8 ký tự)</span>
            <input
              type="password"
              required
              minLength={8}
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="rounded-md border border-slate-300 px-3 py-2 focus:border-indigo-500 focus:outline-none"
            />
          </label>
          <label className="flex flex-col gap-1 text-sm">
            <span className="font-medium text-slate-700">Mục tiêu cấp độ</span>
            <select
              value={targetLevel}
              onChange={(e) => setTargetLevel(e.target.value as JlptLevel)}
              className="rounded-md border border-slate-300 px-3 py-2 focus:border-indigo-500 focus:outline-none"
            >
              {LEVELS.map((level) => (
                <option key={level} value={level}>
                  {level}
                </option>
              ))}
            </select>
          </label>

          {errorMessage && <p className="text-sm text-red-600">{errorMessage}</p>}

          <button
            type="submit"
            disabled={mutation.isPending}
            className="mt-2 rounded-md bg-indigo-600 py-2 text-sm font-semibold text-white hover:bg-indigo-700 disabled:opacity-60"
          >
            {mutation.isPending ? 'Đang đăng ký...' : 'Đăng ký'}
          </button>
        </form>

        <p className="mt-4 text-center text-sm text-slate-500">
          Đã có tài khoản?{' '}
          <Link to="/login" className="font-medium text-indigo-600 hover:underline">
            Đăng nhập
          </Link>
        </p>
      </div>
    </div>
  )
}
