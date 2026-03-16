# proaktive-worker (reference)

Python worker reference implementation.

Consumes SQS messages like:
```json
{ "tenantId": "acme", "documentId": "...", "step": "extract" }
```

Runs placeholder pipeline steps (extract/chunk/map/draft/export).

## Local run
From repo root:

```bash
docker compose up --build
```
