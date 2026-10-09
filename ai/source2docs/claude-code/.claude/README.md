# Japanese Source-to-Documentation Kit for Claude Code

A source-code-only documentation engineering kit for reverse-engineering an undocumented
software system into a Japanese-quality technical documentation set.

## Goal

A new member should be able to answer, in the shortest possible time:

1. What is this system?
2. Why does it exist?
3. What are its major capabilities?
4. How is it structured?
5. How does a request/data/event flow through it?
6. Where are the important business rules?
7. What are the external dependencies and integrations?
8. How is data stored and transformed?
9. How do I run, test, debug, deploy, and operate it?
10. What are the risks, unknowns, and things I must not change casually?

The kit is deliberately **source-code-first**. It does not invent requirements. Every
important statement should be traceable to source evidence, configuration, tests,
schemas, migrations, infrastructure-as-code, or observed build/runtime metadata.

## Design principles

- Evidence before explanation.
- Architecture before implementation detail.
- Reader journey before file inventory.
- Japanese engineering-document style: purpose, scope, assumptions, responsibility,
  interfaces, normal flow, abnormal flow, constraints, operation, risks.
- Unknowns are explicit; they are never silently guessed.
- Keep diagrams close to the explanation they support.
- Prefer generated indexes and cross-links over giant documents.
- Optimize for newcomer time-to-understanding.
- Preserve source terminology exactly where it has semantic meaning.
- Separate facts, inferred behavior, and unresolved questions.

## Recommended output

docs/
  00_README.md
  01_SYSTEM_OVERVIEW.md
  02_ARCHITECTURE.md
  03_MODULE_CATALOG.md
  04_RUNTIME_FLOW.md
  05_BUSINESS_LOGIC.md
  06_DATA_MODEL.md
  07_API_AND_INTEGRATION.md
  08_BATCH_AND_ASYNC.md
  09_ERROR_AND_RECOVERY.md
  10_SECURITY_AND_CONFIGURATION.md
  11_TEST_STRATEGY.md
  12_BUILD_DEPLOY_OPERATION.md
  13_CHANGE_IMPACT_GUIDE.md
  14_NEW_MEMBER_GUIDE.md
  15_GLOSSARY.md
  16_TRACEABILITY.md
  diagrams/
  evidence/
  open_questions/
  generated/

## Claude Code installation

Copy the `skills/` directory into the Claude Code skills location used by your team,
or load the skill files into the repository's `.claude/skills/` structure.

The main skill is:

    skills/japanese-source-to-docs/SKILL.md

The skill orchestrates the specialist agents and templates.

## Typical usage

Start Claude Code at the repository root and ask:

    /japanese-source-to-docs

Or:

    Analyze this repository and generate the complete Japanese technical
    documentation set using the installed source-to-docs skill. Do not guess.
    Produce an evidence ledger and newcomer-first documentation.

For an incremental update:

    Re-analyze only the changed areas and update the documentation and
    traceability matrix. Preserve confirmed facts and mark affected sections.

## Quality gate

Run:

    python scripts/doc_lint.py docs

Then inspect:

    docs/00_README.md
    docs/01_SYSTEM_OVERVIEW.md
    docs/14_NEW_MEMBER_GUIDE.md
    docs/16_TRACEABILITY.md
    docs/open_questions/

## Important

This kit does not claim that source code alone can reveal every business requirement,
production convention, operational procedure, or historical decision. Instead, it
makes those gaps visible and gives the reader a safe path to investigate them.
