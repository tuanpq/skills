import { useState, type ReactNode } from 'react'
import type { StudyStatus } from '../types'

const STATUS_OPTIONS: { value: StudyStatus; label: string; activeClass: string }[] = [
  { value: 'NEW', label: 'Mới', activeClass: 'bg-slate-600 text-white' },
  { value: 'LEARNING', label: 'Đang học', activeClass: 'bg-amber-500 text-white' },
  { value: 'MASTERED', label: 'Đã thuộc', activeClass: 'bg-emerald-600 text-white' },
]

export function Flashcard({
  front,
  back,
  status,
  onStatusChange,
}: {
  front: ReactNode
  back: ReactNode
  status: StudyStatus
  onStatusChange: (status: StudyStatus) => void
}) {
  const [flipped, setFlipped] = useState(false)

  return (
    <div className="flex flex-col overflow-hidden rounded-lg border border-slate-200 bg-white shadow-sm">
      <button
        type="button"
        onClick={() => setFlipped((v) => !v)}
        className="flex min-h-32 flex-1 flex-col items-center justify-center gap-1 px-4 py-6 text-center"
      >
        {flipped ? back : front}
        <span className="mt-2 text-xs text-slate-400">(bấm để lật thẻ)</span>
      </button>
      <div className="flex border-t border-slate-100">
        {STATUS_OPTIONS.map((option) => (
          <button
            key={option.value}
            type="button"
            onClick={() => onStatusChange(option.value)}
            className={`flex-1 py-2 text-xs font-medium transition-colors ${
              status === option.value ? option.activeClass : 'bg-white text-slate-500 hover:bg-slate-50'
            }`}
          >
            {option.label}
          </button>
        ))}
      </div>
    </div>
  )
}
