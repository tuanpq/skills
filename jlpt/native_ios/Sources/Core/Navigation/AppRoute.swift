import Foundation

/// Full-screen destinations pushed onto the root `NavigationStack`, outside the bottom tab bar —
/// mirrors the routes pushed on Android's root `NavHost` (as opposed to the nested per-tab graph).
enum AppRoute: Hashable {
    case review(itemType: StudyItemType)
    case examAttempt(attemptId: Int64)
    case attemptResult(attemptId: Int64)
}
