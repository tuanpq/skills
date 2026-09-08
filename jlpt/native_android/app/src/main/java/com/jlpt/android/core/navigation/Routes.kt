package com.jlpt.android.core.navigation

/** Top-level destinations, reachable from the root [androidx.navigation.NavHost]. */
object Routes {
    const val LOGIN = "login"
    const val REGISTER = "register"
    const val HOME = "home"

    const val REVIEW = "review/{itemType}"
    fun review(itemType: String) = "review/$itemType"

    const val EXAM_ATTEMPT = "attempt/{attemptId}"
    fun examAttempt(attemptId: Long) = "attempt/$attemptId"

    const val ATTEMPT_RESULT = "attempt/{attemptId}/result"
    fun attemptResult(attemptId: Long) = "attempt/$attemptId/result"
}

/** Bottom-navigation destinations nested inside [Routes.HOME]. */
object HomeTabs {
    const val DASHBOARD = "dashboard"
    const val STUDY = "study"
    const val EXAMS = "exams"
    const val PROGRESS = "progress"
}
