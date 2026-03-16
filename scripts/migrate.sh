#!/usr/bin/env bash
set -euo pipefail

DB=${DATABASE_URL:-postgresql://postgres:postgres@localhost:5432/proaktive}

for f in migrations/*.sql; do
  echo "Applying $f"
  psql "$DB" -f "$f"
done
