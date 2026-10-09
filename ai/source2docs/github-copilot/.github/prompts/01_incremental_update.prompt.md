# Incremental Documentation Update

Analyze the current repository against the existing documentation.

Goal: update only what is affected by source changes while preserving confirmed knowledge.

Steps:

1. Detect changed files/modules.
2. Map changed source to evidence.
3. Determine impacted architecture, flows, data, APIs, operations, and tests.
4. Update affected documents.
5. Update diagrams only when topology/flow changed.
6. Update traceability.
7. Add/remove open questions as evidence changes.
8. Run documentation lint.
9. Produce an impact summary:

- Changed area
- Old understanding
- New understanding
- Affected docs
- Affected diagrams
- New risks
- New unknowns
