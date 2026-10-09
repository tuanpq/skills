# Claude Code Orchestration

## Recommended execution strategy

Use specialist agents in waves.

### Wave 1 — Reconnaissance

- repository-cartographer

Output:
- repository inventory
- technology stack
- candidate entry points
- candidate boundaries

### Wave 2 — Independent analysis

Run in parallel:

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

Each agent must produce evidence, not rewrite the complete documentation set.

### Wave 3 — Synthesis

- newcomer-editor

Build the canonical documentation set from evidence.

### Wave 4 — Audit

- documentation-auditor

Correct unsupported claims, contradictions, missing flows, stale references, and
security issues.

## Context efficiency

Do not feed the entire repository to every agent.

Give each specialist:

- relevant files;
- repository inventory;
- existing evidence ledger;
- exact analysis question.

This reduces context usage and increases precision.

## Incremental mode

When source changes:

1. identify changed files;
2. resolve affected symbols/modules;
3. update only affected evidence;
4. calculate impacted documents;
5. regenerate affected sections;
6. run audit.

## Priority rule

If time/context is limited, prioritize:

1. system overview;
2. architecture;
3. primary runtime flow;
4. data model;
5. API/integration;
6. failure/recovery;
7. newcomer guide;
8. traceability;
9. remaining documents.
