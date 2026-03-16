#!/usr/bin/env bash
set -euo pipefail

ENDPOINT=${AWS_ENDPOINT:-http://localhost:4566}
BUCKET=${S3_BUCKET:-proaktive-dev-uploads}
QUEUE_NAME=${SQS_QUEUE_NAME:-doc-ingest}

aws --endpoint-url="$ENDPOINT" s3 mb "s3://$BUCKET" || true
aws --endpoint-url="$ENDPOINT" sqs create-queue --queue-name "$QUEUE_NAME" >/dev/null || true

echo "Localstack initialized: bucket=$BUCKET queue=$QUEUE_NAME"
