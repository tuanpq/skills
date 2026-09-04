import type { GrammarStudy, KanjiStudy, StudyItemType, VocabularyStudy } from '../types'

export type StudyType = 'vocabulary' | 'kanji' | 'grammar'
export type StudyEntry = VocabularyStudy | KanjiStudy | GrammarStudy

export const STUDY_TYPE_META: Record<StudyType, { title: string; itemType: StudyItemType }> = {
  vocabulary: { title: 'Từ vựng', itemType: 'VOCABULARY' },
  kanji: { title: 'Kanji', itemType: 'KANJI' },
  grammar: { title: 'Ngữ pháp', itemType: 'GRAMMAR' },
}

function renderVocabulary(entry: VocabularyStudy) {
  return {
    front: (
      <>
        <p className="text-2xl font-bold text-slate-800">{entry.item.word}</p>
        <p className="text-slate-500">{entry.item.reading}</p>
      </>
    ),
    back: (
      <div className="text-left">
        <p className="font-semibold text-slate-800">{entry.item.meaningVi}</p>
        {entry.item.meaningEn && <p className="text-sm text-slate-500">{entry.item.meaningEn}</p>}
        {entry.item.exampleSentence && (
          <div className="mt-2 border-t border-slate-100 pt-2 text-sm">
            <p className="text-slate-700">{entry.item.exampleSentence}</p>
            <p className="text-slate-400">{entry.item.exampleReading}</p>
            <p className="text-slate-500">{entry.item.exampleMeaning}</p>
          </div>
        )}
      </div>
    ),
  }
}

function renderKanji(entry: KanjiStudy) {
  return {
    front: <p className="text-4xl font-bold text-slate-800">{entry.item.character}</p>,
    back: (
      <div className="text-left">
        <p className="font-semibold text-slate-800">{entry.item.meaningVi}</p>
        <p className="text-sm text-slate-500">音: {entry.item.onyomi ?? '—'}</p>
        <p className="text-sm text-slate-500">訓: {entry.item.kunyomi ?? '—'}</p>
        {entry.item.strokeCount != null && (
          <p className="text-sm text-slate-400">{entry.item.strokeCount} nét</p>
        )}
        {entry.item.exampleWords && (
          <p className="mt-2 border-t border-slate-100 pt-2 text-sm text-slate-600">{entry.item.exampleWords}</p>
        )}
      </div>
    ),
  }
}

function renderGrammar(entry: GrammarStudy) {
  return {
    front: <p className="text-xl font-bold text-slate-800">{entry.item.pattern}</p>,
    back: (
      <div className="text-left">
        <p className="font-semibold text-slate-800">{entry.item.meaningVi}</p>
        {entry.item.usageNote && <p className="text-sm text-slate-500">{entry.item.usageNote}</p>}
        {entry.item.exampleSentence && (
          <div className="mt-2 border-t border-slate-100 pt-2 text-sm">
            <p className="text-slate-700">{entry.item.exampleSentence}</p>
            <p className="text-slate-500">{entry.item.exampleMeaning}</p>
          </div>
        )}
      </div>
    ),
  }
}

export function renderStudyCard(studyType: StudyType, entry: StudyEntry) {
  if (studyType === 'kanji') return renderKanji(entry as KanjiStudy)
  if (studyType === 'grammar') return renderGrammar(entry as GrammarStudy)
  return renderVocabulary(entry as VocabularyStudy)
}
