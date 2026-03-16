# CMMC L2 (NIST 800-171) MVP Spec

## Goal
Ship the fastest sellable wedge: **document-to-control mapping + implementation statement drafting + evidence gap pack** for NIST 800-171/CMMC L2.

## Target user
ISSO / Compliance lead / Security engineer at a government contractor preparing for CMMC L2.

## Inputs
- Uploaded documents (PDF/DOCX/TXT): SSP sections, policies, procedures, diagrams, evidence artifacts.
- Optional: existing control narratives / spreadsheets.

## Outputs (Sellable Pack)
1. **Coverage score** by 800-171 family + overall.
2. **Control-by-control status**: covered / partially / missing (with confidence).
3. **Missing evidence checklist** (actionable items).
4. **Draft implementation statements** for top missing/partial requirements.
5. **POA&M candidates** (title, requirement, gap summary, suggested remediation, priority).
6. **Export**: JSON + PDF/DOCX report.

## Core workflow
1. Upload documents (store in S3).
2. Extract text + metadata.
3. Chunking:
   - strategy: heading-aware + paragraph blocks
   - chunk size target: 800–1,200 tokens with overlap
4. Classification:
   - doc type classifier (policy, procedure, evidence, SSP narrative, diagram text)
5. Control mapping:
   - map chunks to 800-171 requirements
   - store evidence pointers
6. Scoring:
   - compute per-control coverage score (0/0.5/1) with confidence
7. Drafting:
   - generate implementation statements for missing/partial controls
8. Export:
   - generate report artifacts

## Data model (minimum)
- documents(id, tenant_id, filename, s3_key, sha256, mime, status, created_at)
- document_chunks(id, document_id, tenant_id, idx, text, tokens, metadata_json)
- controls(id, framework, control_id, family, title, description, guidance_json)
- control_mappings(id, tenant_id, control_id, chunk_id, score, confidence, rationale)
- implementation_statements(id, tenant_id, control_id, text, version, created_at)
- poam_items(id, tenant_id, control_id, gap_summary, remediation, priority, created_at)

## Non-goals for MVP
- Full FedRAMP 800-53 coverage
- Deep integrations (Jira/Confluence/SharePoint)
- SSO/SAML

## Acceptance criteria
- A user can upload documents and receive an exportable pack within a single session (or async job completion).
- Results are reproducible (same inputs → same artifact versions).
- All actions are audit logged.
