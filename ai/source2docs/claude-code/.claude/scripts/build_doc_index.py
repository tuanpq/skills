#!/usr/bin/env python3
"""Build a simple newcomer-friendly documentation index."""

from pathlib import Path
import sys

ORDER = [
    "00_README.md",
    "01_SYSTEM_OVERVIEW.md",
    "02_ARCHITECTURE.md",
    "03_MODULE_CATALOG.md",
    "04_RUNTIME_FLOW.md",
    "05_BUSINESS_LOGIC.md",
    "06_DATA_MODEL.md",
    "07_API_AND_INTEGRATION.md",
    "08_BATCH_AND_ASYNC.md",
    "09_ERROR_AND_RECOVERY.md",
    "10_SECURITY_AND_CONFIGURATION.md",
    "11_TEST_STRATEGY.md",
    "12_BUILD_DEPLOY_OPERATION.md",
    "13_CHANGE_IMPACT_GUIDE.md",
    "14_NEW_MEMBER_GUIDE.md",
    "15_GLOSSARY.md",
    "16_TRACEABILITY.md",
]

def title(path: Path):
    for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
        if line.startswith("# "):
            return line[2:].strip()
    return path.stem

def main():
    docs = Path(sys.argv[1] if len(sys.argv) > 1 else "docs")
    out = docs / "INDEX.md"
    lines = ["# Documentation Index", "", "## Recommended reading order", ""]
    seen = set()

    for name in ORDER:
        p = docs / name
        if p.exists():
            lines.append(f"- [{title(p)}]({name})")
            seen.add(name)

    lines += ["", "## Other documents", ""]
    for p in sorted(docs.rglob("*.md")):
        rel = p.relative_to(docs).as_posix()
        if rel in seen or rel == "INDEX.md":
            continue
        lines.append(f"- [{title(p)}]({rel})")

    out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(out)

if __name__ == "__main__":
    main()
