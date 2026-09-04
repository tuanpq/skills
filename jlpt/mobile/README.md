# JLPT Mobile (Flutter)

Ứng dụng di động cho JLPT Learning & Practice App, dùng chung REST API với backend Spring Boot.
Cùng bộ tính năng cốt lõi với bản web (frontend/): đăng nhập/đăng ký, học từ vựng/kanji/ngữ pháp
dạng flashcard, làm đề luyện thi + chấm điểm tự động, xem kết quả, theo dõi tiến độ học tập.

## Stack

- Flutter 3.35 / Dart 3.9
- `flutter_riverpod` (state management), `go_router` (routing)
- `dio` (HTTP client, tự gắn JWT + refresh khi hết hạn), `shared_preferences` (lưu phiên đăng nhập)

## Chạy local

Yêu cầu backend đang chạy (mặc định `http://localhost:8080`, xem `backend/README` ở thư mục gốc).

```bash
flutter pub get
flutter run --dart-define=API_BASE_URL=http://localhost:8080
```

Chọn thiết bị bằng `-d <device>` (`flutter devices` để xem danh sách). Ví dụ chạy trên trình duyệt:

```bash
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8080
```

### Lưu ý khi chạy trên Android emulator

Android emulator không thấy `localhost` của máy host — phải trỏ về `10.0.2.2`:

```bash
flutter run -d <android-emulator-id> --dart-define=API_BASE_URL=http://10.0.2.2:8080
```

### CORS khi test bằng Web

Nếu chạy `flutter run -d chrome`, backend cần whitelist origin đang chạy Flutter Web trong
`CORS_ALLOWED_ORIGINS` (backend mặc định đã cho phép `http://localhost:5174`). Native Android/iOS
không bị giới hạn CORS (đây là cơ chế riêng của trình duyệt).

## Test

```bash
flutter analyze
flutter test
```

## Trạng thái build Android/iOS thật

Mã nguồn chỉ dùng widget Flutter chuẩn (không phụ thuộc platform channel riêng), nên chạy như nhau
trên Android/iOS/Web. Bản thân việc build/kiểm thử trên Android emulator hoặc thiết bị thật cần máy
có Android SDK command-line tools đầy đủ (`flutter doctor --android-licenses` đã accept) hoặc Xcode
(cho iOS) — hãy chạy `flutter doctor` để kiểm tra môi trường trước khi build release thật.
