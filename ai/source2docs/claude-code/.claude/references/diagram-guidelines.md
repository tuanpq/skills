# Diagram Guidelines

Use Mermaid unless the repository already standardizes another notation.

## Diagram selection

- Context: flowchart
- Architecture: flowchart
- Runtime interaction: sequenceDiagram
- State transitions: stateDiagram-v2
- Data relationships: erDiagram
- Dependency: flowchart
- Batch pipeline: flowchart + sequenceDiagram

## Rules

1. One diagram = one question.
2. Keep labels readable.
3. Avoid implementation trivia.
4. Link important nodes to source documentation.
5. Do not draw components unsupported by evidence.
6. Use the same names as the source when they matter.
7. Prefer 5–15 nodes; split larger diagrams.
