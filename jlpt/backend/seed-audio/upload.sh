#!/usr/bin/env bash
# Attaches the real audio files in this directory to the 5 seeded
# listening_audios rows (ids 1-5, one per JLPT level) via the admin API.
# Run this once after the backend has started and Flyway has applied
# V2__seed_data.sql (which creates those rows with audio_object_key = NULL).
#
# Usage: ./upload.sh
# Env vars (all optional, defaults match the seeded admin account):
#   API_BASE_URL   default http://localhost:8080
#   ADMIN_EMAIL    default admin@jlpt.local
#   ADMIN_PASSWORD default Admin@12345

set -euo pipefail
cd "$(dirname "$0")"

API_BASE_URL="${API_BASE_URL:-http://localhost:8080}"
ADMIN_EMAIL="${ADMIN_EMAIL:-admin@jlpt.local}"
ADMIN_PASSWORD="${ADMIN_PASSWORD:-Admin@12345}"

TOKEN=$(curl -s -X POST "$API_BASE_URL/api/auth/login" \
  -H "Content-Type: application/json" \
  -d "{\"email\":\"$ADMIN_EMAIL\",\"password\":\"$ADMIN_PASSWORD\"}" \
  | grep -o '"accessToken":"[^"]*"' | cut -d'"' -f4)

if [ -z "$TOKEN" ]; then
  echo "Failed to log in as admin. Check API_BASE_URL/ADMIN_EMAIL/ADMIN_PASSWORD." >&2
  exit 1
fi

# level file -> listening_audios.id, matches V2__seed_data.sql / V5__expand_content.sql insertion order
declare -A ID_MAP=( [n5]=1 [n4]=2 [n3]=3 [n2]=4 [n1]=5 [n5b]=6 [n4b]=7 [n3b]=8 [n2b]=9 [n1b]=10 )

for level in n5 n4 n3 n2 n1 n5b n4b n3b n2b n1b; do
  id=${ID_MAP[$level]}
  echo "Uploading $level.mp3 -> listening_audios id=$id"
  curl -s -o /dev/null -w "  HTTP %{http_code}\n" \
    -X PUT "$API_BASE_URL/api/admin/listening-audios/$id/audio" \
    -H "Authorization: Bearer $TOKEN" \
    -F "file=@$level.mp3;type=audio/mpeg"
done

echo "Done. Verify with: curl $API_BASE_URL/api/listening-audios/1"
