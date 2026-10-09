---
name: japanese-source-to-docs
description: Reverse-engineer an undocumented software system from source code and repository artifacts into a newcomer-first Japanese-quality technical documentation set. Use when a repository has little or no documentation, when onboarding needs to be accelerated, or when existing documentation must be regenerated from implementation evidence.
---

# Japanese Source-to-Documentation Engineering Skill

## Mission

Turn an unfamiliar source repository into a coherent technical knowledge system that
lets a new engineer understand the system quickly and safely.

Do not merely summarize files. Reconstruct:

- system purpose as evidenced by implementation;
- architectural boundaries;
- runtime and data flows;
- responsibilities of components;
- business rules encoded in code;
- APIs and integrations;
- persistence/data model;
- batch/event/asynchronous behavior;
- failure and recovery behavior;
- security/configuration surfaces;
- tests and quality mechanisms;
- build/deployment/operation mechanics;
- change-impact hotspots;
- newcomer learning path;
- unknowns and evidence gaps.

## Non-negotiable rules

1. Never invent a requirement, business rule, endpoint, dependency, or operational
   behavior that is not supported by repository evidence.
2. Every material architectural or behavioral claim must be traceable to evidence.
3. Distinguish:
   - FACT: directly supported by source/config/test/IaC.
   - INFERENCE: strongly inferred from multiple evidence points.
   - UNKNOWN: not established by repository evidence.
4. Preserve exact domain names, class names, table names, event names, queue names,
   environment variables, API paths, and configuration keys where useful.
5. Prefer a diagram plus explanation over a long prose-only description.
6. Explain "why this matters to a new member" for high-complexity areas.
7. Avoid dumping source code into documentation.
8. Record uncertainty rather than hiding it.
9. Update documentation incrementally when source changes; do not rewrite unrelated
   confirmed sections without reason.
10. Never expose secrets found in source or configuration. Redact values and document
    only the existence/meaning of the secret.

## Operating model

Use these phases:

### Phase 0 — Repository reconnaissance

Identify:

- languages/frameworks;
- package/module boundaries;
- build tools;
- entry points;
- test frameworks;
- infrastructure files;
- configuration files;
- database migrations/schema;
- API specifications;
- message/event definitions;
- Docker/CI/CD;
- generated code;
- examples/fixtures.

Produce an inventory before deep analysis.

### Phase 1 — Evidence extraction

Build an evidence ledger.

For each fact record:

- ID;
- category;
- statement;
- source path;
- symbol/config key/line range when available;
- evidence type;
- confidence;
- affected documentation sections.

### Phase 2 — Architecture reconstruction

Reconstruct:

- system context;
- containers/services;
- modules/packages;
- dependencies;
- runtime boundaries;
- persistence;
- external systems;
- synchronous/asynchronous communication;
- deployment topology if supported by IaC/config.

### Phase 3 — Behavior reconstruction

Trace the highest-value flows:

1. main request/use case;
2. main data import/export flow;
3. authentication/authorization;
4. important batch/event flow;
5. failure/retry/recovery flow;
6. important integration flow.

Use sequence diagrams and state diagrams when useful.

### Phase 4 — Knowledge extraction

Extract:

- domain concepts;
- business rules;
- invariants;
- validations;
- transformations;
- transaction boundaries;
- idempotency;
- retry policies;
- concurrency controls;
- error taxonomy;
- configuration;
- security controls;
- operational assumptions.

### Phase 5 — Newcomer synthesis

Write the documentation in reader order, not source-tree order:

1. What is it?
2. How is it organized?
3. How does the main flow work?
4. Where is data?
5. How do integrations work?
6. What can fail?
7. How do I run/test/deploy?
8. What should I understand before changing it?
9. What remains unknown?

### Phase 6 — Verification

Run consistency checks:

- broken internal links;
- diagram references;
- undocumented important modules;
- duplicated/conflicting facts;
- unsupported claims;
- unresolved placeholders;
- secret leakage;
- source paths that no longer exist;
- terminology inconsistencies.

Then run `scripts/doc_lint.py`.

## Specialist agents

Use these roles conceptually or through Claude Code subagents:

- repository-cartographer
- architecture-reconstructor
- runtime-flow-analyst
- domain-rule-miner
- data-model-analyst
- api-integration-analyst
- async-batch-analyst
- failure-recovery-analyst
- security-config-analyst
- test-quality-analyst
- deployment-operation-analyst
- newcomer-editor
- documentation-auditor

Do not allow every agent to independently rewrite the same document. Specialists
produce evidence and focused drafts; the synthesizer owns final structure.

## Output contract

The generated documentation must contain:

- newcomer entry point;
- system overview;
- architecture;
- module catalog;
- runtime flows;
- business logic;
- data model;
- API/integration;
- batch/async;
- errors/recovery;
- security/configuration;
- tests;
- build/deploy/operation;
- change impact;
- glossary;
- traceability;
- open questions.

Each document should contain:

- Purpose
- Scope
- Summary
- Detailed explanation
- Diagram where valuable
- Source evidence
- Unknowns/assumptions where applicable
- Related documents

## Japanese documentation style

Use clear technical Japanese. Avoid unnecessary honorifics.

Recommended section vocabulary:

- 目的
- 対象範囲
- 前提
- システム概要
- 構成
- 責務
- 処理フロー
- データフロー
- 入出力
- 例外処理
- エラー処理
- リトライ
- トランザクション
- セキュリティ
- 設定
- 運用
- テスト
- 制約事項
- 影響範囲
- 未確認事項
- 参照元

## Source-to-document mapping

Use the mapping:

source → evidence → model → diagram/table → explanation → traceability.

Never jump directly from source → polished prose without an evidence step.

## Completion criterion

Consider the job complete only when a new engineer can follow the newcomer guide and
navigate to the answers for:

- purpose;
- architecture;
- primary flow;
- data;
- integrations;
- failure behavior;
- local setup;
- testing;
- deployment/operation;
- change impact.

If the repository cannot establish an answer, the documentation must say `未確認`
and point to the evidence gap.
