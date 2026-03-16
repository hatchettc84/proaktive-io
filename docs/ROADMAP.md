# Roadmap (to first $10k MRR)

## Phase 1 — Paid pilot MVP (2–4 weeks)
**Goal:** ship sellable compliance intelligence workflow.

MVP scope:
1. Auth + tenant model (dev first, FedRAMP-aligned patterns)
2. Document upload (S3) + metadata
3. Chunking pipeline
4. Control library import (start with NIST 800-53 high-level + map skeleton; expand)
5. Mapping UI/workbench (minimal)
6. Outputs:
   - completion score
   - missing evidence list
   - implementation statement drafts
   - POA&M candidates
7. Export: JSON + basic PDF/DOCX
8. Audit log for all actions

## Phase 2 — Agent workforce packaging (4–8 weeks)
- "AI Compliance Analyst" agent bundle
- evidence tracker workflow
- scheduled reporting
- integrations (Jira/Confluence, Google Drive, SharePoint as needed)

## Phase 3 — Scale + enterprise hardening
- SSO
- policy-as-code templates
- stronger tenant isolation tiers (DB-per-tenant)
- expanded control frameworks (CMMC L2, NIST 800-171)

## Phase 4 — FedRAMP pathway
- formalize SDLC controls
- vuln mgmt + scanning + SBOM
- logging/monitoring baselines
- documentation pack generation
