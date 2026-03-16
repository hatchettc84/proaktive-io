# Database Schema (MVP)

Target DB: PostgreSQL.

## Core
### tenants
- id (uuid, pk)
- name (text)
- status (text)
- created_at (timestamptz)

### users
- id (uuid, pk)
- tenant_id (uuid, fk)
- email (citext)
- role (text)
- created_at

### audit_log (append-only)
- id (uuid, pk)
- tenant_id
- actor_user_id (nullable)
- action (text)
- entity_type (text)
- entity_id (text)
- metadata_json (jsonb)
- created_at

## Compliance Engine
### documents
- id (uuid, pk)
- tenant_id (uuid, fk)
- filename
- mime
- sha256
- s3_key
- status (uploaded|extracted|chunked|mapped|exported|error)
- created_at

### document_text
- id (uuid, pk)
- document_id (uuid, fk)
- tenant_id
- s3_key (extracted text artifact)
- text_hash
- created_at

### document_chunks
- id (uuid, pk)
- tenant_id
- document_id
- idx (int)
- text (text)
- token_count (int)
- metadata_json (jsonb) // headings/page refs/etc

### controls
- id (uuid, pk)
- framework (text) // "NIST_800_171"
- control_id (text) // e.g. 3.1.1
- family (text) // e.g. AC
- title (text)
- requirement_text (text)
- guidance_json (jsonb)
- version (text)

### control_mappings
- id (uuid, pk)
- tenant_id
- control_id (text) // or fk to controls
- chunk_id (uuid, fk)
- score (numeric) // 0, 0.5, 1
- confidence (numeric)
- rationale (text)
- created_at

### implementation_statements
- id (uuid, pk)
- tenant_id
- control_id (text)
- text (text)
- citations_json (jsonb) // references to chunks
- version (int)
- created_at

### poam_items
- id (uuid, pk)
- tenant_id
- control_id (text)
- gap_summary (text)
- remediation (text)
- priority (text)
- created_at

## Jobs
### pipeline_jobs
- id (uuid, pk)
- tenant_id
- document_id
- step (text) // extract|chunk|map|draft|export
- input_hash (text)
- status (queued|running|succeeded|failed)
- error (text)
- created_at
- updated_at

## Notes
- Favor immutable artifacts + versioning.
- Idempotency: unique constraint on (tenant_id, document_id, step, input_hash).
