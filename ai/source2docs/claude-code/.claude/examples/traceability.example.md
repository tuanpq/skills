# Traceability Example

| Doc claim | Evidence | Type | Confidence |
|---|---|---|---|
| HTTP request enters OrderController | `src/order/OrderController.ts` | FACT | High |
| Order is persisted before response | `OrderService` → `OrderRepository` | FACT | High |
| Duplicate orders are prevented by unique constraint | migration + repository error handling | INFERENCE | Medium |
| Production alert threshold | No repository evidence | UNKNOWN | Low |
