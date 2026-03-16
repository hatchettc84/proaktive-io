# Compliance Intelligence Engine — System Architecture (MVP)

## Objective
Implement a CMMC L2 / NIST 800-171 pipeline that turns uploaded documents into:
- control coverage scoring
- evidence gaps
- draft implementation statements
- POA&M candidates
- exportable reports

## Services (MVP)
### 1) API service (NestJS)
Responsibilities:
- tenant + auth + RBAC (baseline)
- document metadata CRUD
- presigned upload issuance
- job kickoff endpoints
- serve exports

### 2) Worker service (Python)
Responsibilities:
- text extraction
- chunking
- embeddings/classification
- control mapping
- drafting + export generation

Rationale: Python ecosystem for PDF/DOCX extraction and ML/LLM tooling is strongest; keep orchestration clean.

## Storage
- S3: raw uploads + extracted text + export artifacts
- Postgres: metadata + chunks + mappings + drafts + audit log

## Queueing
- SQS queue per environment:
  - `doc-ingest` jobs (extract/chunk)
  - `control-map` jobs
  - `draft-statements` jobs
  - `export-pack` jobs

Start with one queue + jobType field; split later if needed.

## Idempotency
- Each job uses a deterministic job key: `{tenantId}:{documentId}:{pipelineStep}:{inputHash}`.
- Re-runs create new artifact versions only when inputs change.

## Security baseline (FedRAMP-aligned direction)
- Encrypt S3, RDS, secrets at rest (KMS)
- TLS in transit
- Per-tenant isolation strategy compatible with DB-per-tenant and per-tenant ECS later
- Immutable audit logs (append-only table; later ship to central log store)

## Minimal APIs
- POST /api/v1/documents/upload-url
- POST /api/v1/documents/:id/process
- GET  /api/v1/documents/:id/results
- GET  /api/v1/documents/:id/export

## Output format (JSON)
- summary: overall score + by family
- controls: array of {control_id, status, confidence, evidence_refs[]}
- gaps: missing evidence checklist
- implementation_statements: drafts with citations
- poam: candidates
