import { Link } from 'react-router-dom'
import { useAuthStore } from '../store/authStore'
import { LevelSelect } from '../components/LevelSelect'

const SHORTCUTS = [
  { to: '/study/vocabulary', title: 'Từ vựng', desc: 'Học từ vựng dạng flashcard theo cấp độ' },
  { to: '/study/kanji', title: 'Kanji', desc: 'Học chữ Hán, âm on/kun và cách dùng' },
  { to: '/study/grammar', title: 'Ngữ pháp', desc: 'Ôn các mẫu ngữ pháp theo cấp độ' },
  { to: '/exams', title: 'Luyện thi', desc: 'Làm đề luyện tập tổng hợp và xem kết quả' },
  { to: '/progress', title: 'Tiến độ', desc: 'Theo dõi tiến độ học và lịch sử làm bài' },
]

export function DashboardPage() {
  const user = useAuthStore((state) => state.user)
  const selectedLevel = useAuthStore((state) => state.selectedLevel)
  const setSelectedLevel = useAuthStore((state) => state.setSelectedLevel)

  return (
    <div className="flex flex-col gap-6">
      <div>
        <h1 className="text-2xl font-bold text-slate-800">Xin chào, {user?.displayName} 👋</h1>
        <p className="mt-1 text-slate-500">Chọn cấp độ bạn đang luyện tập:</p>
        <div className="mt-2">
          <LevelSelect value={selectedLevel} onChange={setSelectedLevel} />
        </div>
      </div>

      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {SHORTCUTS.map((item) => (
          <Link
            key={item.to}
            to={item.to}
            className="rounded-lg border border-slate-200 bg-white p-4 shadow-sm transition hover:border-indigo-300 hover:shadow-md"
          >
            <h2 className="font-semibold text-slate-800">{item.title}</h2>
            <p className="mt-1 text-sm text-slate-500">{item.desc}</p>
          </Link>
        ))}
      </div>
    </div>
  )
}
