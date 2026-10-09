# Evidence Model

## Evidence hierarchy

Recommended confidence order:

1. Executable source behavior
2. Database schema/migration/constraint
3. Automated tests that assert behavior
4. Infrastructure-as-code/deployment configuration
5. API/schema definitions
6. Build/CI configuration
7. Configuration defaults
8. Comments/docstrings
9. Naming conventions
10. Inference from structure

Lower-level evidence does not automatically override contradictory higher-level evidence.

## Claim types

### FACT

Directly established by evidence.

### INFERENCE

Not directly stated, but supported by multiple evidence points. Explain reasoning.

### UNKNOWN

Repository evidence is insufficient.

## Evidence record

```text
EV-0001
Claim:
Type:
Source:
Locator:
Reason:
Confidence:
Used by:
```

## Anti-hallucination rule

If two evidence sources conflict, record the conflict. Do not choose silently.
