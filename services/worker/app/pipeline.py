"""Compliance pipeline placeholder steps.

TODO: Implement real steps:
- extract: pull from S3, extract text (pdf/docx), persist text artifact
- chunk: chunk extracted text and persist document_chunks
- map: map chunks to 800-171 controls; persist control_mappings + scoring
- draft: generate implementation statements with citations
- export: create export pack artifacts

This file is intentionally minimal and runnable.
"""

import os


def run_pipeline_step(*, tenant_id: str, document_id: str, step: str):
    print({"tenant": tenant_id, "document": document_id, "step": step})

    if step == "extract":
        # TODO
        print("TODO extract")
        next_step = "chunk"
    elif step == "chunk":
        # TODO
        print("TODO chunk")
        next_step = "map"
    elif step == "map":
        # TODO
        print("TODO map")
        next_step = "draft"
    elif step == "draft":
        # TODO
        print("TODO draft")
        next_step = "export"
    elif step == "export":
        # TODO
        print("TODO export")
        next_step = None
    else:
        raise ValueError(f"Unknown step: {step}")

    # TODO: enqueue next_step back to SQS
    if next_step:
        print(f"TODO enqueue next step: {next_step}")
