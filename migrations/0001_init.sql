-- MVP schema (minimal)

create extension if not exists citext;
create extension if not exists pgcrypto;

create table if not exists tenants (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  status text not null default 'active',
  created_at timestamptz not null default now()
);

create table if not exists users (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references tenants(id) on delete cascade,
  email citext not null,
  role text not null default 'admin',
  created_at timestamptz not null default now()
);

create table if not exists audit_log (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null,
  actor_user_id uuid,
  action text not null,
  entity_type text not null,
  entity_id text not null,
  metadata_json jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create table if not exists documents (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references tenants(id) on delete cascade,
  filename text not null,
  mime text,
  sha256 text,
  s3_key text not null,
  status text not null default 'uploaded',
  created_at timestamptz not null default now()
);

create table if not exists document_chunks (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references tenants(id) on delete cascade,
  document_id uuid not null references documents(id) on delete cascade,
  idx int not null,
  text text not null,
  token_count int,
  metadata_json jsonb not null default '{}'::jsonb
);

create table if not exists controls (
  id uuid primary key default gen_random_uuid(),
  framework text not null,
  control_id text not null,
  family text,
  title text,
  requirement_text text not null,
  guidance_json jsonb not null default '{}'::jsonb,
  version text not null default 'v1'
);

create unique index if not exists controls_uq on controls(framework, control_id, version);

create table if not exists control_mappings (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references tenants(id) on delete cascade,
  control_id text not null,
  chunk_id uuid not null references document_chunks(id) on delete cascade,
  score numeric,
  confidence numeric,
  rationale text,
  created_at timestamptz not null default now()
);

create table if not exists implementation_statements (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references tenants(id) on delete cascade,
  control_id text not null,
  text text not null,
  citations_json jsonb not null default '[]'::jsonb,
  version int not null default 1,
  created_at timestamptz not null default now()
);

create table if not exists poam_items (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references tenants(id) on delete cascade,
  control_id text not null,
  gap_summary text,
  remediation text,
  priority text,
  created_at timestamptz not null default now()
);

create table if not exists pipeline_jobs (
  id uuid primary key default gen_random_uuid(),
  tenant_id uuid not null references tenants(id) on delete cascade,
  document_id uuid not null references documents(id) on delete cascade,
  step text not null,
  input_hash text not null,
  status text not null default 'queued',
  error text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create unique index if not exists pipeline_jobs_uq on pipeline_jobs(tenant_id, document_id, step, input_hash);
