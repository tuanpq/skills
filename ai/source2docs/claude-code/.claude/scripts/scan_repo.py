#!/usr/bin/env python3
"""Generate a lightweight repository inventory for an AI documentation pass."""

from pathlib import Path
import json, sys

IGNORE = {".git", "node_modules", "target", "build", "dist", ".venv", "__pycache__"}

def main():
    root = Path(sys.argv[1] if len(sys.argv) > 1 else ".").resolve()
    result = {
        "root": str(root),
        "files": [],
        "extensions": {},
        "candidate_entry_points": [],
        "candidate_infrastructure": [],
    }

    for p in root.rglob("*"):
        if not p.is_file() or any(part in IGNORE for part in p.parts):
            continue
        rel = p.relative_to(root).as_posix()
        ext = p.suffix.lower() or "<none>"
        result["extensions"][ext] = result["extensions"].get(ext, 0) + 1
        result["files"].append(rel)

        name = p.name.lower()
        if name in {"main.ts", "main.tsx", "main.py", "application.java", "app.py", "index.ts", "server.ts"}:
            result["candidate_entry_points"].append(rel)
        if any(x in name for x in ["dockerfile", "compose", "terraform", "helm", "pom.xml", "package.json", "pnpm-workspace"]):
            result["candidate_infrastructure"].append(rel)

    out = root / ".doc-inventory.json"
    out.write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding="utf-8")
    print(out)

if __name__ == "__main__":
    main()
