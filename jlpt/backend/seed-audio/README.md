# Seed listening audio

10 file mp3 (`n5.mp3`/`n5b.mp3` → `n1.mp3`/`n1b.mp3`, hai file mỗi cấp độ) khớp với transcript đã có
sẵn trong `V2__seed_data.sql` (id 1-5) và `V5__expand_content.sql` (id 6-10, hậu tố `b`). Nội dung đọc
**bằng giọng tổng hợp Windows TTS (Microsoft Haruka, ja-JP)** — không phải thu âm người thật — đủ dùng
để demo/kiểm thử tính năng Nghe thực sự chạy được (audio player, MinIO, presigned URL), không chỉ là
placeholder trống.

## Cách gắn audio vào

Sau khi backend đã chạy (Flyway đã tạo 10 dòng `listening_audios` với `audio_object_key = NULL`):

```bash
cd backend/seed-audio
./upload.sh
```

Script đăng nhập bằng tài khoản admin seed sẵn (`admin@jlpt.local` / `Admin@12345`) rồi gọi
`PUT /api/admin/listening-audios/{id}/audio` cho từng file. Xem biến môi trường tùy chỉnh
(`API_BASE_URL`, `ADMIN_EMAIL`, `ADMIN_PASSWORD`) trong `upload.sh`.

Kiểm tra lại: `curl http://localhost:8080/api/listening-audios/1` phải trả về `audioUrl` khác `null`.
