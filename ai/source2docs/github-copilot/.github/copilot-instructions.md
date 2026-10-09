# Japanese Source-to-Documentation Engineering

Use `.github/skills/japanese-source-to-docs/SKILL.md` when reverse-engineering or documenting this repository.

- Source code, tests, schemas/migrations, configuration, and IaC are primary evidence.
- Never invent requirements, business rules, or operational behavior.
- Classify material claims as `[FACT]`, `[INFERENCE]`, or `[UNKNOWN]`.
- Preserve exact code/domain identifiers where useful.
- Never expose secrets, credentials, tokens, private keys, or secret values.
- Prefer architecture, flows, tables, diagrams, and traceability over file-by-file paraphrases.
- Optimize for newcomer understanding: 5-minute mental model, 30-minute architecture/flow, 60-minute domain/data/integration/failure.
- Documentation language: Japanese. Use Mermaid unless another diagram standard exists.
- Record unresolved questions under `docs/open_questions/`.
- Run `python .github/scripts/doc_lint.py docs` before completion.
