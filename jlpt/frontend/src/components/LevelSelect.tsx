import type { JlptLevel } from '../types'

const LEVELS: JlptLevel[] = ['N5', 'N4', 'N3', 'N2', 'N1']

export function LevelSelect({
  value,
  onChange,
}: {
  value: JlptLevel
  onChange: (level: JlptLevel) => void
}) {
  return (
    <select
      value={value}
      onChange={(e) => onChange(e.target.value as JlptLevel)}
      className="rounded-md border border-slate-300 bg-white px-3 py-1.5 text-sm font-medium text-slate-700 focus:border-indigo-500 focus:outline-none"
    >
      {LEVELS.map((level) => (
        <option key={level} value={level}>
          {level}
        </option>
      ))}
    </select>
  )
}
