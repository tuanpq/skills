import SwiftUI

private struct AppContainerKey: EnvironmentKey {
    /// Real screens always receive a container explicitly injected from `JlptApp`; this default
    /// only exists so previews/tests that don't set one don't crash at launch.
    static let defaultValue = AppContainer()
}

extension EnvironmentValues {
    var appContainer: AppContainer {
        get { self[AppContainerKey.self] }
        set { self[AppContainerKey.self] = newValue }
    }
}
