import json
import os
import time
import boto3

from .pipeline import run_pipeline_step

AWS_REGION = os.getenv("AWS_REGION", "us-east-1")
AWS_ENDPOINT = os.getenv("AWS_ENDPOINT")
QUEUE_URL = os.getenv("SQS_QUEUE_URL")


def sqs_client():
    kwargs = {"region_name": AWS_REGION}
    if AWS_ENDPOINT:
        kwargs["endpoint_url"] = AWS_ENDPOINT
        kwargs["aws_access_key_id"] = "test"
        kwargs["aws_secret_access_key"] = "test"
    return boto3.client("sqs", **kwargs)


def main():
    if not QUEUE_URL:
        raise RuntimeError("SQS_QUEUE_URL is required")

    sqs = sqs_client()
    while True:
        resp = sqs.receive_message(
            QueueUrl=QUEUE_URL,
            MaxNumberOfMessages=1,
            WaitTimeSeconds=20,
        )
        msgs = resp.get("Messages", [])
        if not msgs:
            continue

        msg = msgs[0]
        body = json.loads(msg["Body"])
        tenant_id = body["tenantId"]
        document_id = body["documentId"]
        step = body.get("step", "extract")

        # TODO: add idempotency check using pipeline_jobs
        run_pipeline_step(tenant_id=tenant_id, document_id=document_id, step=step)

        sqs.delete_message(QueueUrl=QUEUE_URL, ReceiptHandle=msg["ReceiptHandle"])
        time.sleep(0.2)


if __name__ == "__main__":
    main()
