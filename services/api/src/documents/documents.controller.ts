import { Body, Controller, Get, Param, Post, Query } from '@nestjs/common';
import { v4 as uuidv4 } from 'uuid';
import AWS from 'aws-sdk';
import { Pool } from 'pg';

// NOTE: reference implementation only.
// Tenant scoping: for MVP local demo, tenantId is passed as query/header. Replace with auth+RBAC.

const pool = new Pool({ connectionString: process.env.DATABASE_URL });

function s3Client() {
  const region = process.env.AWS_REGION || 'us-east-1';
  const endpoint = process.env.AWS_ENDPOINT;
  return new AWS.S3({
    region,
    s3ForcePathStyle: !!endpoint,
    endpoint,
    accessKeyId: 'test',
    secretAccessKey: 'test',
  });
}

function sqsClient() {
  const region = process.env.AWS_REGION || 'us-east-1';
  const endpoint = process.env.AWS_ENDPOINT;
  return new AWS.SQS({
    region,
    endpoint,
    accessKeyId: 'test',
    secretAccessKey: 'test',
  });
}

@Controller('api/v1/documents')
export class DocumentsController {
  @Post('upload-url')
  async createUploadUrl(
    @Query('tenantId') tenantId: string,
    @Body() body: { filename: string; mime?: string }
  ) {
    if (!tenantId) throw new Error('tenantId required');
    const id = uuidv4();
    const bucket = process.env.S3_BUCKET!;
    const key = `${tenantId}/${id}/${body.filename}`;

    const s3 = s3Client();
    const url = await s3.getSignedUrlPromise('putObject', {
      Bucket: bucket,
      Key: key,
      ContentType: body.mime || 'application/octet-stream',
      Expires: 60 * 10,
    });

    await pool.query(
      `insert into documents (id, tenant_id, filename, mime, s3_key, status)
       values ($1, $2, $3, $4, $5, 'uploaded')`,
      [id, tenantId, body.filename, body.mime || null, key]
    );

    return { documentId: id, uploadUrl: url, s3Key: key };
  }

  @Get(':id')
  async getDocument(@Query('tenantId') tenantId: string, @Param('id') id: string) {
    const { rows } = await pool.query(
      `select * from documents where id=$1 and tenant_id=$2`,
      [id, tenantId]
    );
    return rows[0] || null;
  }

  @Post(':id/process')
  async kickoff(@Query('tenantId') tenantId: string, @Param('id') id: string) {
    const queueUrl = process.env.SQS_QUEUE_URL!;
    const sqs = sqsClient();

    await sqs.sendMessage({
      QueueUrl: queueUrl,
      MessageBody: JSON.stringify({ tenantId, documentId: id, step: 'extract' }),
    }).promise();

    return { status: 'queued', step: 'extract' };
  }
}
