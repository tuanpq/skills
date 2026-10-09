#!/usr/bin/env python3
"""Redact common secret-like values from evidence text before documentation."""

from pathlib import Path
import re, sys

PATTERNS = [
    (re.compile(r'(?i)(password\s*[:=]\s*)["\'][^"\']+["\']'), r'\1"<REDACTED>"'),
    (re.compile(r'(?i)(client_secret\s*[:=]\s*)["\'][^"\']+["\']'), r'\1"<REDACTED>"'),
    (re.compile(r'(?i)(aws_secret_access_key\s*[:=]\s*)["\'][^"\']+["\']'), r'\1"<REDACTED>"'),
    (re.compile(r'(?i)(authorization:\s*bearer\s+)[A-Za-z0-9._-]+'), r'\1<REDACTED>'),
]

def redact(text):
    for pattern, repl in PATTERNS:
        text = pattern.sub(repl, text)
    return text

def main():
    if len(sys.argv) != 3:
        print("usage: redact_evidence.py INPUT OUTPUT")
        return 2
    src, dst = map(Path, sys.argv[1:])
    dst.write_text(redact(src.read_text(encoding="utf-8", errors="replace")), encoding="utf-8")
    print(dst)

if __name__ == "__main__":
    raise SystemExit(main())
