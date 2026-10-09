# Architecture Review Prompt

Review the generated architecture documentation against source evidence.

Check:

- component boundaries;
- dependency direction;
- entry points;
- persistence;
- external integrations;
- sync vs async;
- transaction boundaries;
- configuration;
- deployment assumptions;
- architectural patterns;
- hidden coupling.

Report:

| Severity | Finding | Evidence | Documentation impact | Recommendation |

Do not redesign the system unless explicitly requested. The task is to document the
existing architecture accurately.
