# JLPT Learning & Practice App

Ứng dụng học và luyện thi JLPT theo 5 cấp độ (N5 → N1) và 4 phần thi chính thức:
Từ vựng/Kanji (文字・語彙), Ngữ pháp (文法), Đọc hiểu (読解), Nghe hiểu (聴解).

## Trạng thái hiện tại

**Backend** (Spring Boot + PostgreSQL + MinIO), **Frontend** (ReactJS) và **Mobile** (Flutter) đều đã
triển khai đầy đủ luồng chính: đăng ký/đăng nhập, học từ vựng/kanji/ngữ pháp (flashcard + **Ôn tập
SRS** kiểu Anki), làm đề luyện thi + chấm điểm tự động, xem kết quả, theo dõi tiến độ cá nhân —
Frontend và Mobile dùng chung một REST API backend.

## Cấu trúc thư mục

```
jlpt/
├── backend/          # Spring Boot API
├── frontend/         # ReactJS (Vite + TypeScript + Tailwind)
├── mobile/           # Flutter (Android/iOS/Web)
├── infra/
│   └── docker-compose.yml   # postgres + minio + backend + frontend
└── .github/workflows/{backend,frontend,mobile}-ci.yml
```

## Chạy toàn bộ hệ thống bằng Docker (cách nhanh nhất)

```bash
cd infra
docker compose up -d --build
```

- Frontend: `http://localhost:3000`
- Backend Swagger UI: `http://localhost:8080/swagger-ui.html`
- MinIO console: `http://localhost:9001` (đăng nhập `jlpt_admin` / `jlpt_admin_secret`)

## Backend

- Java 21, Spring Boot 3.3, Maven
- PostgreSQL (Flyway migrations), Spring Security + JWT, MinIO cho lưu trữ audio, CORS đã bật cho
  `http://localhost:5173`, `http://localhost:3000` và `http://localhost:5174` (Flutter Web dev — xem
  `mobile/README.md`), cấu hình qua `CORS_ALLOWED_ORIGINS`
- Swagger UI: `/swagger-ui.html`, OpenAPI JSON: `/v3/api-docs`

### Chạy local (dev)

1. Khởi động PostgreSQL + MinIO:

   ```bash
   cd infra
   docker compose up -d postgres minio minio-init
   ```

2. Chạy backend (Flyway sẽ tự động migrate schema + seed dữ liệu mẫu):

   ```bash
   cd backend
   ./mvnw spring-boot:run
   ```

3. Mở Swagger UI tại `http://localhost:8080/swagger-ui.html`.

### Tài khoản mẫu

- Admin (seed sẵn): `admin@jlpt.local` / `Admin@12345` — **đổi mật khẩu trước khi dùng ngoài môi trường local**.
- Người dùng thường: tự đăng ký qua giao diện hoặc `POST /api/auth/register`.

### Dữ liệu mẫu (seed data)

Nội dung từ vựng/kanji/ngữ pháp/bài đọc/bài nghe trong `V2__seed_data.sql` và `V5__expand_content.sql`
là **nội dung gốc do Claude biên soạn**, không sao chép từ đề thi JLPT thật (vì lý do bản quyền). Mỗi
cấp độ (N5→N1) hiện có: **30 từ vựng, 20 kanji, 15 ngữ pháp, 2 bài đọc, 2 bài nghe**, và 1 đề luyện thi
tổng hợp **24 câu** (kết hợp cả 4 kỹ năng). Đây là dữ liệu đủ phong phú để luyện tập thật, nhưng vẫn
nên bổ sung thêm nếu dùng cho mục đích học tập nghiêm túc, lâu dài.

File audio cho 10 mục Nghe (hai mỗi cấp độ) đã có sẵn trong `backend/seed-audio/` (giọng tổng hợp
Windows TTS — xem `backend/seed-audio/README.md`). Sau khi backend chạy lần đầu (Flyway tạo các dòng
`listening_audios` với `audio_object_key = NULL`), chạy:

```bash
cd backend/seed-audio
./upload.sh
```

để gắn audio thật vào MinIO — `GET /api/listening-audios/{id}` sẽ trả về `audioUrl` (presigned URL)
phát được ngay. Có thể upload thêm nội dung Nghe mới qua `POST /api/admin/listening-audios`, hoặc thay
audio cho mục đã có qua `PUT /api/admin/listening-audios/{id}/audio` (yêu cầu tài khoản ADMIN).

### Chạy test

```bash
cd backend
./mvnw test
```

## API chính

- **Auth**: `POST /api/auth/register`, `POST /api/auth/login`, `POST /api/auth/refresh`
- **Nội dung học**: `GET /api/vocabulary`, `GET /api/kanji`, `GET /api/grammar` (theo `?level=`),
  `GET /api/passages/{id}`, `GET /api/listening-audios/{id}`
- **Luyện thi**: `GET /api/exams?level=&skill=`, `GET /api/exams/{id}`,
  `POST /api/exams/{id}/attempts`, `GET /api/attempts/{id}`, `PUT /api/attempts/{id}/answers`,
  `POST /api/attempts/{id}/submit`, `GET /api/attempts/{id}/result`, `GET /api/users/me/attempts`
- **Học tập cá nhân**: `GET /api/study/vocabulary|kanji|grammar`, `POST /api/study/progress`,
  `GET /api/users/me/progress`
- **Ôn tập SRS** (spaced repetition, thuật toán SM-2): `GET /api/study/vocabulary|kanji|grammar/due`
  (danh sách thẻ đến hạn), `POST /api/study/review` (chấm độ nhớ 0-5, tự tính lịch ôn tiếp theo)
- **Admin**: `POST /api/admin/listening-audios` (tạo mục Nghe mới + upload audio),
  `PUT /api/admin/listening-audios/{id}/audio` (thay/gắn audio cho mục đã có)

Chi tiết đầy đủ tham số/schema xem tại Swagger UI khi backend đang chạy.

## Frontend

- Vite + React 18 + TypeScript + Tailwind CSS
- `react-router-dom` (routing), `@tanstack/react-query` (data fetching/cache), `zustand` (auth state,
  persist vào localStorage), `axios` (HTTP client, tự refresh token khi hết hạn)
- Các trang: Đăng nhập/Đăng ký, Trang chủ, Học từ vựng/Kanji/Ngữ pháp (flashcard), **Ôn tập SRS**
  (`/review/:type` — thẻ đến hạn, chấm độ nhớ Lại/Khó/Tốt/Dễ), Danh sách đề luyện thi, Làm bài thi,
  Kết quả bài thi, Tiến độ học tập

### Chạy local (dev)

```bash
cd frontend
npm install
npm run dev
```

Mặc định gọi API tới `http://localhost:8080` (cấu hình qua `frontend/.env`, xem `.env.example`).

### Chạy test / build

```bash
cd frontend
npm test
npm run build
```

## Mobile

- Flutter 3.35 / Dart 3.9, `flutter_riverpod` (state), `go_router` (routing), `dio` (HTTP + tự refresh
  token), `shared_preferences` (lưu phiên đăng nhập)
- Cùng bộ màn hình cốt lõi với web: Đăng nhập/Đăng ký, Trang chủ, Học (tab Từ vựng/Kanji/Ngữ pháp) với
  nút **Ôn tập SRS**, Luyện thi, Làm bài, Kết quả, Tiến độ — điều hướng dạng `BottomNavigationBar`

### Chạy local (dev)

```bash
cd mobile
flutter pub get
flutter run --dart-define=API_BASE_URL=http://localhost:8080
```

Chi tiết (chạy trên Android emulator cần đổi `10.0.2.2`, chạy Web cần CORS, v.v.) xem
`mobile/README.md`.

### Chạy test

```bash
cd mobile
flutter analyze
flutter test
```

## CI/CD

Ba workflow trong `.github/workflows/`, mỗi cái chỉ chạy khi thư mục tương ứng thay đổi:

| Workflow | Chạy khi | Việc làm |
| --- | --- | --- |
| `backend-ci.yml` | push/PR đụng `backend/` | `mvn test` → build jar → build Docker image; **push lên GHCR** nếu là push vào `main` |
| `frontend-ci.yml` | push/PR đụng `frontend/` | lint + `npm test` → build → build Docker image; **push lên GHCR** nếu là push vào `main` |
| `mobile-ci.yml` | push/PR đụng `mobile/` | `flutter analyze` + `flutter test` + `flutter build web` (chỉ kiểm thử, không publish app) |

Job `push-image` (backend/frontend) chỉ chạy khi push vào `main`, dùng `GITHUB_TOKEN` có sẵn (không
cần tạo secret) để đẩy image lên **GitHub Container Registry**:

- `ghcr.io/<owner>/jlpt-backend:latest` và `:<git-sha>`
- `ghcr.io/<owner>/jlpt-frontend:latest` và `:<git-sha>` — build-arg `VITE_API_BASE_URL` lấy từ repo
  variable `VITE_API_BASE_URL` (Settings → Secrets and variables → Actions → Variables), mặc định
  `http://localhost:8080` nếu chưa cấu hình

**Repo hiện chỉ có git local, chưa kết nối GitHub** — các workflow trên đã sẵn sàng nhưng chưa chạy
lần nào. Để kích hoạt:

1. Tạo repo trên GitHub rồi `git remote add origin <url>` + `git push -u origin master`
2. Vào **Settings → Actions → General → Workflow permissions**, bật "Read and write permissions" (để
   `GITHUB_TOKEN` được phép push image lên GHCR)
3. Sau lần push đầu tiên vào `main`, các package sẽ xuất hiện ở tab **Packages** của repo/tổ chức

**Chưa có bước deploy lên server/PaaS thật** (chưa có hạ tầng đích) — khi có server, có thể thêm một
job kéo image mới nhất qua SSH (`docker pull ghcr.io/.../jlpt-backend:latest && docker compose up -d`)
hoặc trỏ một PaaS (Render/Railway/Fly.io...) đọc trực tiếp từ GHCR.

## Roadmap tiếp theo

1. Kết nối repo GitHub thật + bật workflow permissions để CI/CD ở trên thực sự chạy
2. Chọn hạ tầng đích (VPS/PaaS) và thêm bước deploy tự động sau khi push image
3. Build/publish app Android (Play Store) và iOS (App Store)
4. (Tùy chọn) Mở rộng thêm seed data (nhiều từ vựng/kanji/ngữ pháp/đề thi hơn nữa)
5. (Tùy chọn) Thay audio TTS bằng giọng thu âm người thật cho trải nghiệm tự nhiên hơn
