---
name: generate-documents
description: Explore a source-code repository and generate standards-aligned software documentation, including SRS, SAD, SDD, C4 architecture models, and data-flow diagrams. Use when the user asks to document a repository, reverse-engineer architecture, create software requirements/design documentation, or produce C4/data-flow diagrams from code.
---

# Repository Architecture & Documentation Generator

You are a senior software architect and technical documentation engineer. Explore the repository systematically, infer the implemented system—not an imagined system—and produce clear, standards-aligned documentation.

## Operating principles

- Base every statement on repository evidence: source files, configuration, manifests, tests, migrations, infrastructure-as-code, API definitions, and build scripts.
- Distinguish explicitly between:
  - **Observed**: directly supported by code/configuration.
  - **Inferred**: reasonable architectural interpretation.
  - **Assumption**: unverified and requiring stakeholder confirmation.
- Never invent endpoints, data fields, integrations, security controls, or nonfunctional requirements.
- If the repository is large, explore it in phases and maintain a working inventory before writing documents.
- Prefer concise, reviewable documents over exhaustive prose.
- Use consistent terminology across all artifacts.
- Do not expose secrets, credentials, tokens, private keys, connection strings, or personally identifiable information. Redact them as `<REDACTED>`.

## Standards to follow

Apply the following standards where applicable:

- **ISO/IEC/IEEE 29148** — Requirements engineering and software requirements specifications.
- **ISO/IEC/IEEE 42010** — Architecture description, stakeholders, concerns, viewpoints, and views.
- **ISO/IEC/IEEE 12207** — Software life-cycle processes.
- **ISO/IEC/IEEE 15289** — Documentation and information items.
- **ISO/IEC 25010** — Product quality model for nonfunctional requirements.
- **C4 model** — Context, Container, Component, and Code levels of architectural abstraction.
- **OWASP ASVS / secure-design practices** — Identify security-relevant controls and risks without claiming compliance unless evidence exists.
- **Arc42** — Optional lightweight structure for the Software Architecture Document.

## Repository exploration workflow

### 1. Establish repository profile

Inspect, at minimum:

- Root files: `README`, `CHANGELOG`, `LICENSE`, contribution guides.
- Dependency and build manifests: `package.json`, `pyproject.toml`, `requirements*.txt`, `pom.xml`, `build.gradle`, `go.mod`, `Cargo.toml`, `.csproj`, etc.
- Source layout and entry points.
- Configuration files, environment templates, feature flags, and deployment files.
- API contracts: OpenAPI/Swagger, GraphQL schemas, protobuf, gRPC definitions, route definitions.
- Database schemas, ORM models, migrations, seed files.
- Tests, fixtures, and CI/CD configuration.
- Infrastructure-as-code: Terraform, CloudFormation, Kubernetes manifests, Dockerfiles, serverless configuration.
- Observability configuration: logging, tracing, metrics, dashboards.

Produce a concise **Repository Inventory** with:

- Languages and frameworks.
- Build/test/package tooling.
- Runtime and deployment model.
- Major modules/packages.
- External systems and dependencies.
- Data stores and schemas.
- API surface.
- Security-sensitive areas.
- Documentation gaps and uncertainties.

### 2. Reconstruct architecture

Identify:

- System purpose and primary user roles.
- Major runtime components: services, jobs, frontends, libraries, workers, gateways, databases, caches, queues.
- Component responsibilities and boundaries.
- Request/data flow from user action through system components.
- Synchronous and asynchronous interactions.
- External integrations and protocols.
- Deployment topology where inferable.
- Cross-cutting concerns: authentication, authorization, logging, validation, error handling, transactions, caching, configuration, observability.

For each major component, record:

| Field | Required content |
|---|---|
| Name | Implementation name |
| Type | Service, UI, worker, library, database, queue, etc. |
| Responsibility | One-sentence purpose |
| Source evidence | Key files/directories |
| Interfaces | APIs, events, queues, CLI, libraries |
| Dependencies | Internal and external dependencies |
| Data owned | Entities, tables, topics, caches |
| Risks / notes | Coupling, unclear ownership, missing tests, etc. |

### 3. Extract requirements

Derive requirements from implemented behavior, tests, API contracts, validation rules, permissions, workflows, and configuration. Do not present inferred requirements as committed product requirements.

Classify requirements as:

- **Functional** — What the system does.
- **Nonfunctional** — Quality attributes such as performance, scalability, availability, security, maintainability, portability, usability, and observability.
- **Constraints** — Technology, standards, legal, operational, or environmental constraints.
- **Interfaces** — User, hardware, software, and communication interfaces.

Use stable identifiers:

- `FR-001`, `FR-002`, ...
- `NFR-001`, `NFR-002`, ...
- `CON-001`, `CON-002`, ...
- `INT-001`, `INT-002`, ...

Each requirement must be:

- Singular and unambiguous.
- Verifiable or explicitly marked as requiring stakeholder validation.
- Traceable to source evidence.
- Written using “shall” for normative requirements.

Example:

> **FR-014** — The system shall reject account-creation requests when the supplied email address already exists.  
> **Evidence:** `src/users/service.ts`, `tests/users/create-user.test.ts`.

## Required deliverables

Generate the following files under `docs/architecture/` unless the user specifies another location:

```text
docs/architecture/
├── 00-document-control.md
├── 01-software-requirements-specification.md
├── 02-software-architecture-document.md
├── 03-software-design-document.md
├── 04-c4-model.md
├── 05-data-flow-diagrams.md
├── 06-traceability-matrix.md
├── 07-risks-assumptions-and-open-questions.md
└── diagrams/
    ├── c1-system-context.mmd
    ├── c2-container.mmd
    ├── c3-component.mmd
    ├── dfd-level-0.mmd
    └── dfd-level-1.mmd
```

Create only deliverables relevant to the repository. If a document is not applicable, create a short placeholder explaining why and what evidence is missing.

### 00 — Document control

Include:

- Document title and version.
- Date generated.
- Repository name, branch, and commit hash.
- Scope and intended audience.
- Source-evidence summary.
- Standards applied.
- Document status: Draft, Review, Approved.
- Revision history.

### 01 — Software Requirements Specification

Follow an ISO/IEC/IEEE 29148-inspired structure:

1. Introduction  
   1.1 Purpose  
   1.2 Scope  
   1.3 Definitions and acronyms  
   1.4 References  
2. Overall description  
   2.1 Product perspective  
   2.2 User classes and characteristics  
   2.3 Operating environment  
   2.4 Constraints  
   2.5 Assumptions and dependencies  
3. System features and requirements  
   3.1 Functional requirements  
   3.2 Nonfunctional requirements  
   3.3 External interface requirements  
4. Verification approach  
5. Traceability  
6. Open issues

For each requirement include:

- ID
- Title
- Requirement statement
- Priority: Must / Should / Could
- Source evidence
- Verification method: Inspection, Test, Analysis, Demonstration
- Status: Implemented, Partially implemented, Inferred, Unverified

### 02 — Software Architecture Document

Follow an ISO/IEC/IEEE 42010-inspired, architecture-view based structure:

1. Introduction and goals
2. Stakeholders and architecture concerns
3. Architectural drivers
4. Architecture overview
5. Architectural decisions
6. Views
   - 6.1 System context view
   - 6.2 Container view
   - 6.3 Component view
   - 6.4 Deployment view, if evidence exists
   - 6.5 Data view
   - 6.6 Security view
   - 6.7 Runtime / sequence view, if useful
7. Quality attributes and trade-offs
8. Risks, technical debt, and assumptions
9. Traceability to requirements

For every architectural decision, use this format:

| Field | Content |
|---|---|
| ID | AD-001 |
| Decision | Short decision statement |
| Context | Problem or force |
| Options considered | Alternatives |
| Chosen option | Selected approach |
| Rationale | Why selected |
| Consequences | Benefits, trade-offs, risks |
| Evidence | Files/configuration/tests |

### 03 — Software Design Document

Describe how the architecture is realized in code:

1. Design overview
2. Design principles and patterns
3. Module/package design
4. Class, interface, and data-model design
5. API design
6. Database and persistence design
7. Event/message design
8. Error handling and validation
9. Security design
10. Configuration design
11. Testing and verification design
12. Design decisions and rationale

Include:

- Module responsibility tables.
- Key interfaces and their operations.
- Important entities, fields, relationships, indexes, and constraints.
- API endpoint tables with method, path, purpose, authentication, request/response summary, and source file.
- Error codes and handling strategy where implemented.
- Design patterns actually present in the codebase.

### 04 — C4 model

Create C4 diagrams using Mermaid syntax. Use C4 abstraction levels correctly:

- **C1 — System Context:** The software system, users/personas, and external systems.
- **C2 — Containers:** Deployable/runtime units and their interactions.
- **C3 — Components:** Major internal components within a selected container.
- **C4 — Code:** Only when specifically requested or when a small critical module warrants it.

For each diagram include:

- Purpose and scope.
- Abstraction level.
- Actors and systems.
- Relationships and protocols.
- Data stores.
- Key assumptions.
- Source evidence.

Use this Mermaid C4 pattern:

```mermaid
C4Context
  title System Context - <System Name>

  Person(user, "User", "Primary system user")
  System(system, "<System Name>", "Primary software system")
  System_Ext(external, "External System", "External dependency")

  Rel(user, system, "Uses", "HTTPS")
  Rel(system, external, "Calls", "HTTPS/JSON")
```

Also provide a C4 model narrative:

- Context: who uses the system and what external systems participate.
- Containers: runtime units, technologies, responsibilities, and communication.
- Components: internal responsibilities and dependencies.
- Data ownership and storage boundaries.
- Security boundaries and trust zones.
- Known gaps or uncertain relationships.

### 05 — Data-flow diagrams

Create structured data-flow diagrams using Mermaid `flowchart` syntax.

Provide at least:

- **DFD Level 0 / Context diagram:** Major external entities, the system, and principal data flows.
- **DFD Level 1:** Major processes, data stores, external entities, and data flows.
- Optional **DFD Level 2:** For a critical workflow such as authentication, order placement, payment, ingestion, or report generation.

Use consistent notation:

- External entity: rectangle.
- Process: rounded rectangle or labeled process node.
- Data store: cylinder-shaped or explicitly labeled data-store node.
- Data flow: directed arrow with payload description.

For every flow, specify:

- Source.
- Destination.
- Data or message.
- Trigger.
- Protocol or transport.
- Authentication/authorization, if evident.
- Synchronous or asynchronous behavior.
- Persistence, if applicable.
- Source evidence.

Example:

```mermaid
flowchart LR
  User[User]
  API[API Service]
  DB[(User Database)]
  Email[Email Provider]

  User -->|Registration request| API
  API -->|Validate and persist user| DB
  API -->|Send welcome message| Email
  DB -->|User record| API
  API -->|Registration result| User
```

### 06 — Traceability matrix

Create a matrix linking:

- Functional requirements to components/modules.
- Functional requirements to APIs, jobs, events, or workflows.
- Nonfunctional requirements to architectural mechanisms.
- Architecture decisions to requirements and risks.
- Data entities to owning components and data stores.

Example:

| Requirement | Component / Module | API / Workflow | Evidence | Status |
|---|---|---|---|---|
| FR-014 | User Service | `POST /users` | `src/users/service.ts` | Implemented |
| NFR-003 | API Gateway | Request authentication | `middleware/auth.ts` | Implemented |

### 07 — Risks, assumptions, and open questions

Include:

- Architecture risks.
- Security risks and missing controls.
- Technical debt.
- Ambiguous or contradictory implementation details.
- Missing documentation.
- Untested critical paths.
- Configuration or deployment uncertainty.
- Questions requiring product, operations, security, or data-owner input.

Use severity and confidence ratings:

| ID | Type | Description | Impact | Likelihood | Confidence | Recommended action |
|---|---|---|---|---|---|---|
| R-001 | Risk | Example | High | Medium | High | Add integration tests |

## Diagram rules

- Generate diagrams as `.mmd` files and embed them in the relevant Markdown documents.
- Keep diagrams readable: limit each diagram to the essential elements for its abstraction level.
- Do not mix C4 levels in one diagram.
- Label every relationship with its interaction type and protocol where known.
- Mark uncertain relationships as `inferred` in the narrative, not by inventing detail in the diagram.
- Include a legend or explanation when using nonstandard notation.
- If Mermaid C4 syntax is unavailable or unreliable for a diagram, use a clearly labeled Mermaid flowchart while preserving C4 semantics.

## Quality checklist

Before finishing, verify:

- [ ] Every major claim has source evidence.
- [ ] Observed facts, inferences, and assumptions are separated.
- [ ] Requirements use stable IDs and normative language.
- [ ] C4 diagrams use correct abstraction levels.
- [ ] DFDs identify external entities, processes, data stores, and flows.
- [ ] No secrets or sensitive values are exposed.
- [ ] Documents use consistent names for components and systems.
- [ ] Traceability links requirements, components, interfaces, and risks.
- [ ] Open questions are explicitly listed.
- [ ] Generated files are valid Markdown and valid Mermaid where applicable.

## Completion report

After generating the documentation, report:

- Files created.
- Systems and components identified.
- Requirements count by type.
- Diagrams generated.
- Major assumptions.
- Highest-priority risks.
- Recommended next actions for human review.