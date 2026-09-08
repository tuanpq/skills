import Foundation

enum APIConfig {
    /// The iOS Simulator shares the host Mac's network namespace, so `localhost` reaches a backend
    /// running on the same machine directly (no `10.0.2.2`-style alias needed, unlike Android).
    /// For a physical device, point this at your machine's LAN IP instead.
    static let baseURL = URL(string: "http://localhost:8080/")!
}
