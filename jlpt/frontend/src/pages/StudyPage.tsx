import { Link, useParams } from 'react-router-dom'
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import {
  fetchGrammarDue,
  fetchGrammarStudy,
  fetchKanjiDue,
  fetchKanjiStudy,
  fetchVocabularyDue,
  fetchVocabularyStudy,
  updateProgress,
} from '../api/study'
import { useAuthStore } from '../store/authStore'
import { LevelSelect } from '../components/LevelSelect'
import { Flashcard } from '../components/Flashcard'
import { renderStudyCard, STUDY_TYPE_META, type StudyEntry, type StudyType } from '../lib/studyCardRender'
import type { StudyStatus } from '../types'

export function StudyPage() {
  const { type } = useParams<{ type: StudyType }>()
  const studyType = (type ?? 'vocabulary') as StudyType
  const meta = STUDY_TYPE_META[studyType]

  const selectedLevel = useAuthStore((state) => state.selectedLevel)
  const setSelectedLevel = useAuthStore((state) => state.setSelectedLevel)
  const queryClient = useQueryClient()

  const queryKey = ['study', studyType, selectedLevel]
  const { data, isLoading } = useQuery<StudyEntry[]>({
    queryKey,
    queryFn: async (): Promise<StudyEntry[]> => {
      if (studyType === 'kanji') return fetchKanjiStudy(selectedLevel)
      if (studyType === 'grammar') return fetchGrammarStudy(selectedLevel)
      return fetchVocabularyStudy(selectedLevel)
    },
  })

  const dueQueryKey = ['study-due-count', studyType, selectedLevel]
  const { data: dueCount } = useQuery({
    queryKey: dueQueryKey,
    queryFn: async (): Promise<number> => {
      if (studyType === 'kanji') return (await fetchKanjiDue(selectedLevel)).length
      if (studyType === 'grammar') return (await fetchGrammarDue(selectedLevel)).length
      return (await fetchVocabularyDue(selectedLevel)).length
    },
  })

  const statusMutation = useMutation({
    mutationFn: ({ itemId, status }: { itemId: number; status: StudyStatus }) =>
      updateProgress(meta.itemType, itemId, status),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey })
    },
  })

  return (
    <div className="flex flex-col gap-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <h1 className="text-2xl font-bold text-slate-800">{meta.title}</h1>
        <LevelSelect value={selectedLevel} onChange={setSelectedLevel} />
      </div>

      <Link
        to={`/review/${studyType}`}
        className="flex items-center justify-between rounded-lg border border-indigo-200 bg-indigo-50 px-4 py-3 text-sm font-semibold text-indigo-700 hover:bg-indigo-100"
      >
        <span>🔁 Ôn tập ngay</span>
        <span>{dueCount ?? '…'} thẻ đến hạn</span>
      </Link>

      {isLoading && <p className="text-slate-500">Đang tải...</p>}
      {!isLoading && data?.length === 0 && (
        <p className="text-slate-500">Chưa có dữ liệu cho cấp độ này.</p>
      )}

      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {data?.map((entry) => {
          const rendered = renderStudyCard(studyType, entry)

          return (
            <Flashcard
              key={entry.item.id}
              front={rendered.front}
              back={rendered.back}
              status={entry.status}
              onStatusChange={(status) => statusMutation.mutate({ itemId: entry.item.id, status })}
            />
          )
        })}
      </div>
    </div>
  )
}
