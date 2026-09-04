import { useState } from 'react'
import { useNavigate, useParams } from 'react-router-dom'
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { fetchAttempt, submitAnswer, submitAttempt } from '../api/exams'
import { QuestionForm } from '../components/QuestionForm'

export function ExamAttemptPage() {
  const { attemptId } = useParams<{ attemptId: string }>()
  const id = Number(attemptId)
  const navigate = useNavigate()
  const queryClient = useQueryClient()

  const { data: attempt, isLoading } = useQuery({
    queryKey: ['attempt', id],
    queryFn: () => fetchAttempt(id),
  })

  const [answers, setAnswers] = useState<Record<number, number>>({})

  const answerMutation = useMutation({
    mutationFn: ({ questionId, choiceId }: { questionId: number; choiceId: number }) =>
      submitAnswer(id, questionId, choiceId),
  })

  const submitMutation = useMutation({
    mutationFn: () => submitAttempt(id),
    onSuccess: (result) => {
      queryClient.setQueryData(['attempt-result', id], result)
      navigate(`/attempts/${id}/result`)
    },
  })

  if (isLoading || !attempt) {
    return <p className="text-slate-500">Đang tải đề thi...</p>
  }

  const answeredCount = Object.keys(answers).length
  const totalQuestions = attempt.questions.length

  function handleSelect(questionId: number, choiceId: number) {
    setAnswers((prev) => ({ ...prev, [questionId]: choiceId }))
    answerMutation.mutate({ questionId, choiceId })
  }

  return (
    <div className="flex flex-col gap-4">
      <div className="flex flex-wrap items-center justify-between gap-2">
        <div>
          <h1 className="text-2xl font-bold text-slate-800">{attempt.examTitle}</h1>
          <p className="text-sm text-slate-500">
            Đã trả lời {answeredCount}/{totalQuestions} câu
          </p>
        </div>
        <button
          onClick={() => submitMutation.mutate()}
          disabled={submitMutation.isPending}
          className="rounded-md bg-emerald-600 px-5 py-2 text-sm font-semibold text-white hover:bg-emerald-700 disabled:opacity-60"
        >
          {submitMutation.isPending ? 'Đang nộp bài...' : 'Nộp bài'}
        </button>
      </div>

      <div className="flex flex-col gap-4">
        {attempt.questions.map((question, index) => (
          <QuestionForm
            key={question.id}
            index={index}
            question={question}
            selectedChoiceId={answers[question.id] ?? null}
            onSelect={(choiceId) => handleSelect(question.id, choiceId)}
          />
        ))}
      </div>

      <button
        onClick={() => submitMutation.mutate()}
        disabled={submitMutation.isPending}
        className="self-end rounded-md bg-emerald-600 px-5 py-2 text-sm font-semibold text-white hover:bg-emerald-700 disabled:opacity-60"
      >
        {submitMutation.isPending ? 'Đang nộp bài...' : 'Nộp bài'}
      </button>
    </div>
  )
}
