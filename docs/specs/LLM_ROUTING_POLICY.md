# LLM / Embeddings Routing Policy (Draft)

## Goals
- Minimize cost while preserving quality for compliance drafting.
- Support sensitive-document processing controls.

## Recommendation (MVP — speed-first)
### Default posture
**OpenAI-first** for mapping + drafting to move fastest, with an explicit customer-controlled setting to disable external model calls.

### Embeddings
- Default: OpenAI embeddings (fastest to implement) or pgvector-ready interface.
- Store vectors in Postgres (pgvector) or a simple vector store depending on existing stack.

### Models
- **Cheap model**: summarization, classification, chunk labeling.
- **Strong model**: control mapping rationale + implementation statement drafting.
- **Strongest model**: only for final, customer-facing polished exports.

## Data sensitivity modes
- **Mode A (default, fastest):** OpenAI for mapping + drafting.
- **Mode B (tight):** Bedrock models in AWS boundary (feature flag).
- **Mode C (tightest):** Local/Ollama for most tasks with optional strong model for final drafts.

## Open questions
- Are customer docs allowed to leave AWS boundary? If not, prioritize Bedrock.
- Target monthly model budget for MVP?
