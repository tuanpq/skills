#!/usr/bin/env python3
"""Lightweight documentation quality gate.

Usage:
    python scripts/doc_lint.py docs
"""

from __future__ import annotations
import re
import sys
from pathlib import Path

REQUIRED = [
    "00_README.md",
    "01_SYSTEM_OVERVIEW.md",
    "02_ARCHITECTURE.md",
    "04_RUNTIME_FLOW.md",
    "06_DATA_MODEL.md",
    "07_API_AND_INTEGRATION.md",
    "09_ERROR_AND_RECOVERY.md",
    "12_BUILD_DEPLOY_OPERATION.md",
    "14_NEW_MEMBER_GUIDE.md",
    "16_TRACEABILITY.md",
]

SECRET_PATTERNS = [
    re.compile(r"(?i)(aws_secret_access_key|private_key|client_secret)\s*[:=]\s*['\"][^'\"]+"),
    re.compile(r"(?i)(password|passwd|token)\s*[:=]\s*['\"][^'\"]+"),
]

def main():
    docs = Path(sys.argv[1] if len(sys.argv) > 1 else "docs")
    errors, warnings = [], []

    if not docs.exists():
        print(f"ERROR: {docs} does not exist")
        return 2

    for name in REQUIRED:
        if not (docs / name).exists():
            errors.append(f"Missing required document: {name}")

    md_files = list(docs.rglob("*.md"))

    for p in md_files:
        text = p.read_text(encoding="utf-8", errors="replace")
        if "TODO" in text or "TBD" in text:
            warnings.append(f"Unresolved TODO/TBD: {p}")
        if "未確認" not in text and p.name not in {"00_README.md"}:
            warnings.append(f"No explicit 未確認事項 section/marker: {p}")
        for pat in SECRET_PATTERNS:
            if pat.search(text):
                errors.append(f"Possible secret leakage: {p}")

        # Check relative markdown links.
        for target in re.findall(r"\[[^\]]+\]\(([^)#]+)\)", text):
            if target.startswith(("http://", "https://", "mailto:")):
                continue
            target_path = (p.parent / target).resolve()
            if not target_path.exists():
                warnings.append(f"Broken relative link: {p} -> {target}")

    print(f"Scanned {len(md_files)} markdown files")
    print(f"Errors: {len(errors)}")
    print(f"Warnings: {len(warnings)}")

    for item in errors:
        print("ERROR:", item)
    for item in warnings:
        print("WARN :", item)

    return 1 if errors else 0

if __name__ == "__main__":
    raise SystemExit(main())
