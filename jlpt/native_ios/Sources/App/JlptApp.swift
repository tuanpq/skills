import SwiftUI

@main
struct JlptApp: App {
    private let container = AppContainer()

    var body: some Scene {
        WindowGroup {
            RootView(container: container)
                .environment(\.appContainer, container)
        }
    }
}
