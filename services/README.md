# Services (reference implementation)

- `api/`: NestJS API (presign upload, document metadata, kickoff jobs)
- `worker/`: Python worker (SQS consumer + pipeline skeleton)

Run locally via `docker compose up --build` from repo root.
