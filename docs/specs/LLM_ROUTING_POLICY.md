# LLM / Embeddings Routing Policy (Draft)

## Goals
- Minimize cost while preserving quality for compliance drafting.
- Support sensitive-document processing controls.

## Recommendation (MVP)
### Embeddings
- Default: local or low-cost provider (depending on where docs are processed)
- Store vectors in a managed vector store or Postgres pgvector.

### Models
- **Cheap model**: summarization, classification, chunk labeling.
- **Strong model**: control mapping rationale + implementation statement drafting.
- **Strongest model**: only for executive synthesis/customer-facing polished exports.

## Data sensitivity modes
- Mode A (fastest): OpenAI for drafting; store only necessary text snippets.
- Mode B (tighter): Bedrock models in AWS boundary.
- Mode C (tightest): Ollama local for most tasks; strong model for final drafts only.

## Open questions
- Are customer docs allowed to leave AWS boundary? If not, prioritize Bedrock.
- Target monthly model budget for MVP?
