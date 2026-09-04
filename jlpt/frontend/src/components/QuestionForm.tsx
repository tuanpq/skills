import { useQuery } from '@tanstack/react-query'
import { fetchListeningAudio } from '../api/content'
import type { QuestionForAttempt } from '../types'

const SKILL_LABELS: Record<string, string> = {
  VOCABULARY: 'Từ vựng',
  GRAMMAR: 'Ngữ pháp',
  READING: 'Đọc hiểu',
  LISTENING: 'Nghe hiểu',
}

export function QuestionForm({
  index,
  question,
  selectedChoiceId,
  onSelect,
  result,
}: {
  index: number
  question: QuestionForAttempt
  selectedChoiceId: number | null
  onSelect: (choiceId: number) => void
  result?: { correctChoiceId: number | null; correct: boolean }
}) {
  const { data: audio } = useQuery({
    queryKey: ['listening-audio', question.listeningAudioId],
    queryFn: () => fetchListeningAudio(question.listeningAudioId as number),
    enabled: question.listeningAudioId != null,
  })

  return (
    <div className="rounded-lg border border-slate-200 bg-white p-4 shadow-sm">
      <div className="mb-2 flex items-center gap-2">
        <span className="rounded bg-indigo-50 px-2 py-0.5 text-xs font-semibold text-indigo-600">
          {SKILL_LABELS[question.skillType] ?? question.skillType}
        </span>
        <span className="text-xs text-slate-400">Câu {index + 1}</span>
      </div>

      {question.passageContent && (
        <p className="mb-3 rounded-md bg-slate-50 p-3 text-sm leading-relaxed text-slate-700">
          {question.passageContent}
        </p>
      )}

      {question.listeningAudioId != null && (
        <div className="mb-3 rounded-md bg-slate-50 p-3">
          {audio?.audioUrl ? (
            <audio controls src={audio.audioUrl} className="w-full" />
          ) : (
            <p className="text-sm italic text-slate-400">Audio chưa được tải lên cho câu hỏi này.</p>
          )}
        </div>
      )}

      <p className="mb-3 font-medium text-slate-800">{question.questionText}</p>

      <div className="flex flex-col gap-2">
        {question.choices.map((choice) => {
          const isSelected = selectedChoiceId === choice.id
          let stateClass = 'border-slate-200 hover:border-indigo-300'
          if (result) {
            if (choice.id === result.correctChoiceId) {
              stateClass = 'border-emerald-500 bg-emerald-50'
            } else if (isSelected && !result.correct) {
              stateClass = 'border-red-500 bg-red-50'
            }
          } else if (isSelected) {
            stateClass = 'border-indigo-500 bg-indigo-50'
          }

          return (
            <label
              key={choice.id}
              className={`flex cursor-pointer items-center gap-2 rounded-md border px-3 py-2 text-sm ${stateClass}`}
            >
              <input
                type="radio"
                name={`question-${question.id}`}
                checked={isSelected}
                disabled={!!result}
                onChange={() => onSelect(choice.id)}
              />
              {choice.choiceText}
            </label>
          )
        })}
      </div>
    </div>
  )
}
