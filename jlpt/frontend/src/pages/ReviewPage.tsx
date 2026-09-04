import { useState } from 'react'
import { Link, useParams } from 'react-router-dom'
import { useMutation, useQuery } from '@tanstack/react-query'
import { fetchGrammarDue, fetchKanjiDue, fetchVocabularyDue, submitReview } from '../api/study'
import { useAuthStore } from '../store/authStore'
import { renderStudyCard, STUDY_TYPE_META, type StudyEntry, type StudyType } from '../lib/studyCardRender'

const RATING_OPTIONS: { label: string; quality: number; className: string }[] = [
  { label: 'Lại', quality: 0, className: 'bg-red-600 hover:bg-red-700' },
  { label: 'Khó', quality: 3, className: 'bg-amber-500 hover:bg-amber-600' },
  { label: 'Tốt', quality: 4, className: 'bg-emerald-600 hover:bg-emerald-700' },
  { label: 'Dễ', quality: 5, className: 'bg-sky-600 hover:bg-sky-700' },
]

export function ReviewPage() {
  const { type } = useParams<{ type: StudyType }>()
  const studyType = (type ?? 'vocabulary') as StudyType
  const meta = STUDY_TYPE_META[studyType]
  const selectedLevel = useAuthStore((state) => state.selectedLevel)

  const { data: queue, isLoading } = useQuery<StudyEntry[]>({
    queryKey: ['study-due', studyType, selectedLevel],
    queryFn: async () => {
      if (studyType === 'kanji') return fetchKanjiDue(selectedLevel)
      if (studyType === 'grammar') return fetchGrammarDue(selectedLevel)
      return fetchVocabularyDue(selectedLevel)
    },
  })

  const [index, setIndex] = useState(0)
  const [flipped, setFlipped] = useState(false)

  const reviewMutation = useMutation({
    mutationFn: ({ itemId, quality }: { itemId: number; quality: number }) =>
      submitReview(meta.itemType, itemId, quality),
    onSuccess: () => {
      setIndex((i) => i + 1)
      setFlipped(false)
    },
  })

  if (isLoading) {
    return <p className="text-slate-500">Đang tải...</p>
  }

  const total = queue?.length ?? 0
  const current = queue?.[index]

  if (!current) {
    return (
      <div className="flex flex-col items-center gap-4 rounded-lg border border-slate-200 bg-white p-10 text-center shadow-sm">
        <p className="text-4xl">🎉</p>
        <h1 className="text-xl font-bold text-slate-800">
          {total === 0 ? 'Không có thẻ nào đến hạn hôm nay' : 'Hoàn thành! Không còn thẻ nào đến hạn hôm nay'}
        </h1>
        <Link
          to={`/study/${studyType}`}
          className="rounded-md bg-indigo-600 px-4 py-2 text-sm font-semibold text-white hover:bg-indigo-700"
        >
          Quay lại {meta.title}
        </Link>
      </div>
    )
  }

  const rendered = renderStudyCard(studyType, current)

  return (
    <div className="mx-auto flex max-w-md flex-col gap-4">
      <div className="flex items-center justify-between">
        <h1 className="text-xl font-bold text-slate-800">Ôn tập · {meta.title}</h1>
        <span className="text-sm text-slate-500">
          {index + 1}/{total}
        </span>
      </div>

      <button
        type="button"
        onClick={() => setFlipped((v) => !v)}
        className="flex min-h-48 flex-col items-center justify-center gap-2 rounded-lg border border-slate-200 bg-white p-6 text-center shadow-sm"
      >
        {flipped ? rendered.back : rendered.front}
        {!flipped && <span className="mt-3 text-xs text-slate-400">(bấm để xem đáp án)</span>}
      </button>

      {flipped && (
        <div className="grid grid-cols-4 gap-2">
          {RATING_OPTIONS.map((option) => (
            <button
              key={option.quality}
              type="button"
              disabled={reviewMutation.isPending}
              onClick={() => reviewMutation.mutate({ itemId: current.item.id, quality: option.quality })}
              className={`rounded-md py-3 text-sm font-semibold text-white disabled:opacity-60 ${option.className}`}
            >
              {option.label}
            </button>
          ))}
        </div>
      )}
    </div>
  )
}
