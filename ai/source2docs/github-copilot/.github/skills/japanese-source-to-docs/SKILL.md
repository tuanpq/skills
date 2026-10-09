---
name: japanese-source-to-docs
description: Reverse-engineer an undocumented repository from source code into a newcomer-first Japanese technical documentation system with evidence, diagrams, traceability, and unknown tracking.
---
# Japanese Source-to-Documentation Skill

## Mission
Create the fastest and most visual path for a new engineer to understand an undocumented system.

## Non-negotiable
1. Source/config/tests/IaC are evidence.
2. Never invent requirements.
3. Classify material claims as FACT, INFERENCE, UNKNOWN.
4. Record `Evidence: path :: symbol/heading :: locator`.
5. Redact secrets.
6. Prefer architecture and flows over file summaries.
7. Unknowns become `未確認`, never guesses.

## Workflow
1. Repository reconnaissance: stack, modules, entry points, tests, schemas, APIs, events, infrastructure, configuration, generated code.
2. Evidence ledger: claim, type, source, locator, confidence, usage.
3. Architecture: context, services, components, dependencies, persistence, external systems, sync/async, deployment evidence.
4. Behavior: primary request/data flow, auth, batch/event, failure/retry, integrations.
5. Knowledge: domain rules, invariants, validation, transformations, transactions, idempotency, concurrency, errors, configuration, security.
6. Synthesis in newcomer order: mental model → architecture → primary flow → domain/data → integrations → failure → development → tests → deployment → change impact → glossary → unknowns.
7. Audit: unsupported claims, contradictions, stale paths, broken links, secret leakage, diagram mismatch, terminology drift.

## Japanese style
Use: 目的, 対象範囲, 前提, 構成, 責務, 処理フロー, データフロー, 入出力, 例外処理, リトライ, トランザクション, セキュリティ, 設定, 運用, テスト, 制約事項, 影響範囲, 未確認事項, 参照元.

## Required docs
Generate the canonical `docs/00_README.md` through `docs/16_TRACEABILITY.md` set from the existing templates, plus `docs/evidence`, `docs/open_questions`, `docs/diagrams`, and `docs/generated`.

## Copilot execution
Use `.github/agents/*.agent.md` for specialist roles, `.github/prompts/*.prompt.md` for reusable entry points, `.github/instructions/*.instructions.md` for scoped rules, and this skill for detailed workflow. Recommended waves: cartography → specialist analysis → newcomer synthesis → audit. Specialists provide evidence; the orchestrator owns canonical docs.
