import { Link, useParams } from 'react-router-dom'
import { useQuery } from '@tanstack/react-query'
import { fetchAttemptResult } from '../api/exams'

export function AttemptResultPage() {
  const { attemptId } = useParams<{ attemptId: string }>()
  const id = Number(attemptId)

  const { data: result, isLoading } = useQuery({
    queryKey: ['attempt-result', id],
    queryFn: () => fetchAttemptResult(id),
  })

  if (isLoading || !result) {
    return <p className="text-slate-500">Đang tải kết quả...</p>
  }

  const percentage = result.maxScore > 0 ? Math.round((result.score / result.maxScore) * 100) : 0

  return (
    <div className="flex flex-col gap-4">
      <div className="rounded-lg border border-slate-200 bg-white p-6 text-center shadow-sm">
        <p className="text-sm font-medium text-slate-500">Điểm số</p>
        <p className="text-4xl font-bold text-indigo-600">
          {result.score}/{result.maxScore}
        </p>
        <p className="mt-1 text-sm text-slate-400">{percentage}% chính xác</p>
      </div>

      <div className="flex flex-col gap-4">
        {result.answers.map((answer, index) => (
          <div
            key={answer.questionId}
            className={`rounded-lg border p-4 shadow-sm ${
              answer.correct ? 'border-emerald-200 bg-emerald-50' : 'border-red-200 bg-red-50'
            }`}
          >
            <p className="text-xs font-semibold text-slate-500">
              Câu {index + 1} · {answer.correct ? 'Đúng' : 'Sai'}
            </p>
            <p className="mt-1 font-medium text-slate-800">{answer.questionText}</p>
            {answer.explanation && (
              <p className="mt-2 text-sm text-slate-600">{answer.explanation}</p>
            )}
          </div>
        ))}
      </div>

      <div className="flex gap-3">
        <Link
          to="/exams"
          className="rounded-md border border-slate-300 px-4 py-2 text-sm font-medium text-slate-600 hover:bg-slate-100"
        >
          Quay lại danh sách đề
        </Link>
        <Link
          to="/progress"
          className="rounded-md bg-indigo-600 px-4 py-2 text-sm font-semibold text-white hover:bg-indigo-700"
        >
          Xem tiến độ
        </Link>
      </div>
    </div>
  )
}
