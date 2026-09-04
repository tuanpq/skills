import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { fetchExams, startAttempt } from '../api/exams'
import { useAuthStore } from '../store/authStore'
import { LevelSelect } from '../components/LevelSelect'
import type { SkillType } from '../types'

const SKILL_OPTIONS: { value: SkillType | ''; label: string }[] = [
  { value: '', label: 'Tất cả kỹ năng' },
  { value: 'VOCABULARY', label: 'Từ vựng' },
  { value: 'GRAMMAR', label: 'Ngữ pháp' },
  { value: 'READING', label: 'Đọc hiểu' },
  { value: 'LISTENING', label: 'Nghe hiểu' },
]

export function ExamListPage() {
  const navigate = useNavigate()
  const queryClient = useQueryClient()
  const selectedLevel = useAuthStore((state) => state.selectedLevel)
  const setSelectedLevel = useAuthStore((state) => state.setSelectedLevel)
  const [skill, setSkill] = useState<SkillType | ''>('')

  const { data: exams, isLoading } = useQuery({
    queryKey: ['exams', selectedLevel, skill],
    queryFn: () => fetchExams(selectedLevel, skill || undefined),
  })

  const startMutation = useMutation({
    mutationFn: (examId: number) => startAttempt(examId),
    onSuccess: (attempt) => {
      queryClient.setQueryData(['attempt', attempt.id], attempt)
      navigate(`/attempts/${attempt.id}`)
    },
  })

  return (
    <div className="flex flex-col gap-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <h1 className="text-2xl font-bold text-slate-800">Luyện thi</h1>
        <div className="flex gap-2">
          <LevelSelect value={selectedLevel} onChange={setSelectedLevel} />
          <select
            value={skill}
            onChange={(e) => setSkill(e.target.value as SkillType | '')}
            className="rounded-md border border-slate-300 bg-white px-3 py-1.5 text-sm font-medium text-slate-700 focus:border-indigo-500 focus:outline-none"
          >
            {SKILL_OPTIONS.map((option) => (
              <option key={option.value} value={option.value}>
                {option.label}
              </option>
            ))}
          </select>
        </div>
      </div>

      {isLoading && <p className="text-slate-500">Đang tải...</p>}
      {!isLoading && exams?.length === 0 && <p className="text-slate-500">Chưa có đề cho cấp độ này.</p>}

      <div className="flex flex-col gap-3">
        {exams?.map((exam) => (
          <div
            key={exam.id}
            className="flex items-center justify-between rounded-lg border border-slate-200 bg-white p-4 shadow-sm"
          >
            <div>
              <h2 className="font-semibold text-slate-800">{exam.title}</h2>
              <p className="text-sm text-slate-500">
                {exam.questionCount} câu · {exam.timeLimitMinutes} phút
              </p>
            </div>
            <button
              onClick={() => startMutation.mutate(exam.id)}
              disabled={startMutation.isPending}
              className="rounded-md bg-indigo-600 px-4 py-2 text-sm font-semibold text-white hover:bg-indigo-700 disabled:opacity-60"
            >
              Bắt đầu
            </button>
          </div>
        ))}
      </div>
    </div>
  )
}
