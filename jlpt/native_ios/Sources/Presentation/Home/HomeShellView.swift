import SwiftUI

/// Bottom tab bar hosting the four main sections. Lives inside the root `NavigationStack`, so
/// `push` appends to the *shared* path — pushing a route (review, exam attempt, result) replaces
/// the tab bar entirely, same as the Android app's root `NavHost` routes living outside `HomeShell`.
struct HomeShellView: View {
    let container: AppContainer
    let push: (AppRoute) -> Void

    var body: some View {
        TabView {
            NavigationStack {
                DashboardView(container: container)
            }
            .tabItem { Label("Trang chủ", systemImage: "house.fill") }

            NavigationStack {
                StudyView(container: container, push: push)
                    .navigationTitle("Học")
            }
            .tabItem { Label("Học", systemImage: "book.fill") }

            NavigationStack {
                ExamListView(container: container, push: push)
                    .navigationTitle("Luyện thi")
            }
            .tabItem { Label("Luyện thi", systemImage: "pencil.and.list.clipboard") }

            NavigationStack {
                ProgressScreenView(container: container)
            }
            .tabItem { Label("Tiến độ", systemImage: "chart.line.uptrend.xyaxis") }
        }
    }
}
