# Definition of Done (MVP)

An MVP feature/issue is **Done** when:

## Engineering
- [ ] Code merged to `main` via PR
- [ ] Unit/integration tests added or updated
- [ ] Lint/typecheck passing
- [ ] Feature flag / config gating where appropriate

## Security / Compliance baseline
- [ ] Tenant-scoped access enforced (no cross-tenant reads/writes)
- [ ] Sensitive actions are audit logged
- [ ] Secrets are not stored in code or logs

## Operability
- [ ] Structured logs for key steps
- [ ] Errors are actionable (include correlation/job id)
- [ ] Idempotency strategy documented for async jobs

## Product
- [ ] Acceptance criteria in the issue are met
- [ ] Output artifacts are exportable where relevant
- [ ] Documentation updated (`docs/specs/*` if it’s a pipeline change)
