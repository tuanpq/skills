# JLPT – Native iOS (SwiftUI + Clean Architecture)

A native iOS client for the JLPT learning/practice app, consuming the same Spring Boot REST API as
`../frontend` (React), `../mobile` (Flutter), and `../native_android` (Kotlin). Built with Swift and
SwiftUI, layered as Clean Architecture (`presentation` → `domain` → `data`), and using **zero
third-party dependencies** — only Foundation, SwiftUI, Security (Keychain), and AVFoundation.

## Project format

This project uses [XcodeGen](https://github.com/yonaskolb/XcodeGen) instead of committing a
generated `.xcodeproj` — `project.yml` is the source of truth, which keeps the diff clean and avoids
merge conflicts in Xcode's project file.

```bash
brew install xcodegen   # one-time, if you don't already have it
cd native_ios
xcodegen generate       # produces JlptApp.xcodeproj
open JlptApp.xcodeproj
```

Re-run `xcodegen generate` any time `project.yml` changes. `JlptApp.xcodeproj` itself is gitignored.

## Stack

- Swift 5.9, SwiftUI, iOS 16+ (`NavigationStack`/`NavigationPath`)
- Structured concurrency end-to-end: `async`/`await`, `AsyncStream` for reactive session state, an
  `actor` (`TokenStore`) as the single source of truth for the JWT session
- `URLSession`-based `APIClient` with a 401-refresh-and-retry flow that dedupes concurrent refresh
  attempts onto one in-flight `Task` (mirrors the frontend's axios interceptor and the Android app's
  OkHttp `Authenticator`)
- Keychain (via the `Security` framework) for persisting the session across launches
- `AVFoundation` (`AVPlayer`) for listening-question audio playback
- No Hilt/Dagger equivalent needed: `AppContainer` (`Core/DI`) is a small hand-written composition
  root; use cases are plain structs with `callAsFunction`, matching Kotlin's `operator fun invoke`

## Architecture

```
Sources/
├── App/            # @main entry point, root navigation (Login/Register vs. tab-based Home)
├── Core/           # cross-cutting: networking, Keychain, DI container, navigation routes, theme
├── Domain/         # models, repository protocols, use cases — no Foundation networking/Codable
├── Data/           # DTOs (Codable), typed API wrappers, mappers, repository implementations
└── Presentation/   # one folder per feature (Auth, Home, Study, Review, Exam, Progress), each
                     # with SwiftUI views + an `@MainActor ObservableObject` view model
```

`Domain` has no dependency on `Data`, `Foundation`'s `Codable`, or `URLSession`; `Data` implements
the `Domain.Repositories` protocols using DTOs + mappers; `Presentation` only talks to `Domain` (use
cases + models), never to DTOs or `APIClient` directly.

## Feature parity with the Android/Flutter apps

- Đăng nhập / Đăng ký (with target JLPT level picker), session persisted in Keychain + silently
  refreshed on 401
- Học từ vựng / Kanji / Ngữ pháp theo cấp độ (N5-N1) — flip-flashcard browsing
- **Ôn tập SRS**: due-card queue per type, rate recall (Lại/Khó/Tốt/Dễ → SM-2 on the backend)
- Manual progress marking (Mới/Đang học/Đã thuộc), independent of SRS
- Đề luyện thi: filter by level + skill, start an attempt, answer with autosave, resume in-progress
  attempts, listening-audio playback inline, submit → scored result with per-question explanation
- Lịch sử làm bài (attempt history)
- Tiến độ học tập (progress dashboard) + đăng xuất

## Running against the backend

The backend must be running first (see the root `README.md` — `cd infra && docker compose up -d`,
or `cd backend && ./mvnw spring-boot:run`).

- **iOS Simulator**: no changes needed — the Simulator shares the host Mac's network namespace, so
  `APIConfig.baseURL` (`http://localhost:8080/`) reaches a backend running on the same machine
  directly.
- **Physical device**: change `APIConfig.baseURL` in `Sources/Core/Networking/APIConfig.swift` to
  your Mac's LAN IP (e.g. `http://192.168.1.20:8080/`).
- `Resources/Info.plist` allows plain HTTP only to loopback/local hosts
  (`NSAppTransportSecurity` → `NSAllowsLocalNetworking`); all other traffic still requires HTTPS.

## Note on this scaffold

This project was authored and code-reviewed without access to a Mac/Xcode toolchain, so it has not
been build-verified the way the Android app was (`./gradlew assembleDebug` succeeded there). The
code follows standard, well-established Swift/SwiftUI/XcodeGen patterns throughout, but the first
`xcodegen generate` + build in Xcode is the real test — if it surfaces errors, they should be
narrow and mechanical (an import, a type inference hint) rather than structural.
