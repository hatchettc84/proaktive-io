# proaktive-api (reference)

NestJS API reference implementation.

## Endpoints
- `GET /api/v1/health`
- `POST /api/v1/documents/upload-url?tenantId=...` { filename, mime? }
- `GET /api/v1/documents/:id?tenantId=...`
- `POST /api/v1/documents/:id/process?tenantId=...`

## Local run (with docker compose)
From repo root:

```bash
docker compose up --build
```

Then create localstack resources (one-time):

```bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://proaktive-dev-uploads
aws --endpoint-url=http://localhost:4566 sqs create-queue --queue-name doc-ingest
```
