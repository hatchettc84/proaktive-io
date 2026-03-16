# Architecture (initial)

## Product
ProAktive IO is a modular multi-tenant platform.

Core modules:
- Tenant + RBAC
- Audit logging
- Document intelligence (upload, chunk, embed, classify)
- Compliance engine (controls, mappings, gaps, statements, POA&M)
- Workflow automation (tasks, approvals)
- Analytics dashboard

## Infra direction (FedRAMP-aligned)
- AWS (ECS/ECR/ALB/ACM/RDS/S3/Secrets/KMS/CloudWatch)
- Encrypted storage + least privilege
- Environment separation: dev/stage/prod
- Tenant routing via subdomains (`{tenant}-api.isso-ai.com`)

## Near-term deployment
- `/api/*` served by NestJS on ECS (tenant-specific service)
- `/chat/*` stays Lambda until stabilized
