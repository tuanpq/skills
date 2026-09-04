import { Link } from 'react-router-dom'
import { useQuery } from '@tanstack/react-query'
import { fetchMyProgress } from '../api/study'
import { fetchMyAttempts } from '../api/exams'
import type { StudyItemType, StudyStatus } from '../types'

const ITEM_TYPE_LABELS: Record<StudyItemType, string> = {
  VOCABULARY: 'Từ vựng',
  KANJI: 'Kanji',
  GRAMMAR: 'Ngữ pháp',
}

const STATUS_LABELS: Record<StudyStatus, string> = {
  NEW: 'Mới',
  LEARNING: 'Đang học',
  MASTERED: 'Đã thuộc',
}

export function ProgressPage() {
  const { data: progress } = useQuery({ queryKey: ['my-progress'], queryFn: fetchMyProgress })
  const { data: attempts } = useQuery({ queryKey: ['my-attempts'], queryFn: fetchMyAttempts })

  return (
    <div className="flex flex-col gap-6">
      <div>
        <h1 className="mb-3 text-2xl font-bold text-slate-800">Tiến độ học tập</h1>
        <div className="grid grid-cols-1 gap-4 sm:grid-cols-3">
          {(Object.keys(ITEM_TYPE_LABELS) as StudyItemType[]).map((itemType) => {
            const counts = progress?.countsByItemTypeAndStatus[itemType] ?? {}
            return (
              <div key={itemType} className="rounded-lg border border-slate-200 bg-white p-4 shadow-sm">
                <h2 className="font-semibold text-slate-800">{ITEM_TYPE_LABELS[itemType]}</h2>
                <ul className="mt-2 flex flex-col gap-1 text-sm text-slate-600">
                  {(Object.keys(STATUS_LABELS) as StudyStatus[]).map((status) => (
                    <li key={status} className="flex justify-between">
                      <span>{STATUS_LABELS[status]}</span>
                      <span className="font-medium">{counts[status] ?? 0}</span>
                    </li>
                  ))}
                </ul>
              </div>
            )
          })}
        </div>
      </div>

      <div>
        <h2 className="mb-3 text-xl font-bold text-slate-800">Lịch sử làm bài</h2>
        {attempts?.length === 0 && <p className="text-slate-500">Chưa có lượt làm bài nào.</p>}
        <div className="flex flex-col gap-2">
          {attempts?.map((attempt) => (
            <div
              key={attempt.id}
              className="flex items-center justify-between rounded-lg border border-slate-200 bg-white p-3 shadow-sm"
            >
              <div>
                <p className="font-medium text-slate-800">{attempt.examTitle}</p>
                <p className="text-xs text-slate-400">
                  {new Date(attempt.startedAt).toLocaleString('vi-VN')} ·{' '}
                  {attempt.status === 'SUBMITTED' ? 'Đã nộp' : 'Đang làm'}
                </p>
              </div>
              {attempt.status === 'SUBMITTED' ? (
                <Link
                  to={`/attempts/${attempt.id}/result`}
                  className="rounded-md border border-slate-300 px-3 py-1.5 text-sm font-medium text-slate-600 hover:bg-slate-100"
                >
                  {attempt.score}/{attempt.maxScore} điểm
                </Link>
              ) : (
                <Link
                  to={`/attempts/${attempt.id}`}
                  className="rounded-md bg-indigo-600 px-3 py-1.5 text-sm font-medium text-white hover:bg-indigo-700"
                >
                  Tiếp tục
                </Link>
              )}
            </div>
          ))}
        </div>
      </div>
    </div>
  )
}
