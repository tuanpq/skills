# GitHub Copilot Japanese Source-to-Documentation Kit

Source-code-only reverse engineering kit for undocumented systems. It creates a Japanese-quality, newcomer-first technical knowledge base using GitHub Copilot customization.

## Goal
A new member should quickly understand system purpose, architecture, main flows, business rules, data, integrations, async/batch behavior, failures, security/configuration, tests, deployment/operation, and change impact.

## Copilot-native structure
`.github/copilot-instructions.md`, `.github/instructions/`, `.github/agents/`, `.github/prompts/`, `.github/skills/`, `.github/templates/`, `.github/references/`, `.github/scripts/`.

## Start
Use the `docs-orchestrator` custom agent or the `generate-documentation.prompt.md` prompt.

## Evidence rule
`Source → Evidence → Model → Diagram/Table → Explanation → Traceability`. Facts, inferences, and unknowns are explicitly separated.
