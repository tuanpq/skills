# JLPT – Native Android (Kotlin + Jetpack Compose)

A native Android client for the JLPT learning/practice app, consuming the same Spring Boot REST API
as `../frontend` (React) and `../mobile` (Flutter). Built with Kotlin, Jetpack Compose, and a
single-module Clean Architecture layering (`presentation` → `domain` → `data`).

## Stack

- Kotlin 2.0 / Jetpack Compose (Material 3), single `:app` module
- Hilt for dependency injection
- Retrofit + OkHttp + kotlinx.serialization for networking, with an `Authenticator` that
  transparently refreshes the JWT access token on a 401 (mirrors the frontend's axios interceptor
  and the Flutter app's dio interceptor)
- DataStore (Preferences) for persisting the signed-in session across app restarts
- Navigation Compose for routing, Media3 ExoPlayer for listening-question audio playback
- Coroutines/Flow end-to-end (repositories return a domain `AppResult<T>`, ViewModels expose
  `StateFlow<UiState>`)

## Architecture

```
app/src/main/java/com/jlpt/android/
├── core/            # cross-cutting: DI modules, networking, DataStore, navigation, theme
├── data/            # DTOs, Retrofit API interfaces, mappers, repository implementations
├── domain/          # models, repository interfaces, use cases — no Android/Retrofit imports
└── presentation/    # one package per feature (auth, home, study, review, exam, progress),
                      # each with Compose screens + a Hilt ViewModel
```

`domain` has no dependency on `data` or Android framework classes; `data` implements the
`domain.repository` interfaces using Retrofit DTOs + mappers; `presentation` only talks to
`domain` (use cases + models), never to DTOs or Retrofit directly.

## Feature parity with the Flutter app

- Đăng nhập / Đăng ký (with target JLPT level picker), session persisted + silently refreshed
- Học từ vựng / Kanji / Ngữ pháp theo cấp độ (N5-N1) — flashcard browsing, tap to flip
- **Ôn tập SRS**: due-card queue per type, rate recall (Lại/Khó/Tốt/Dễ → SM-2 on the backend)
- Manual progress marking (Mới/Đang học/Đã thuộc), independent of SRS
- Đề luyện thi: filter by level + skill, start an attempt, answer with autosave, resume in-progress
  attempts, listening-audio playback inline, submit → scored result with per-question explanation
- Lịch sử làm bài (attempt history)
- Tiến độ học tập (progress dashboard) + đăng xuất

## Running against the backend

The backend must be running first (see the root `README.md` — `cd infra && docker compose up -d`,
or `cd backend && ./mvnw spring-boot:run`).

- **Emulator**: no changes needed — debug builds point at `http://10.0.2.2:8080/`, which the
  Android emulator resolves to the host machine's `localhost`.
- **Physical device**: change `API_BASE_URL` in `app/build.gradle.kts` to your machine's LAN IP
  (e.g. `http://192.168.1.20:8080/`) and add that host to
  `app/src/main/res/xml/network_security_config.xml` (cleartext HTTP is only allowed for the hosts
  listed there).

## Build & run

```bash
cd native_android
./gradlew :app:assembleDebug
# or, with a device/emulator connected:
./gradlew :app:installDebug
```

`local.properties` (gitignored) must point `sdk.dir` at your Android SDK install.
