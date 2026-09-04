import { Navigate, Route, Routes } from 'react-router-dom'
import { Layout } from './components/Layout'
import { ProtectedRoute } from './components/ProtectedRoute'
import { LoginPage } from './pages/LoginPage'
import { RegisterPage } from './pages/RegisterPage'
import { DashboardPage } from './pages/DashboardPage'
import { StudyPage } from './pages/StudyPage'
import { ReviewPage } from './pages/ReviewPage'
import { ExamListPage } from './pages/ExamListPage'
import { ExamAttemptPage } from './pages/ExamAttemptPage'
import { AttemptResultPage } from './pages/AttemptResultPage'
import { ProgressPage } from './pages/ProgressPage'

export function App() {
  return (
    <Routes>
      <Route path="/login" element={<LoginPage />} />
      <Route path="/register" element={<RegisterPage />} />

      <Route
        element={
          <ProtectedRoute>
            <Layout />
          </ProtectedRoute>
        }
      >
        <Route path="/" element={<DashboardPage />} />
        <Route path="/study/:type" element={<StudyPage />} />
        <Route path="/review/:type" element={<ReviewPage />} />
        <Route path="/exams" element={<ExamListPage />} />
        <Route path="/attempts/:attemptId" element={<ExamAttemptPage />} />
        <Route path="/attempts/:attemptId/result" element={<AttemptResultPage />} />
        <Route path="/progress" element={<ProgressPage />} />
      </Route>

      <Route path="*" element={<Navigate to="/" replace />} />
    </Routes>
  )
}
