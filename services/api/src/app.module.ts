import { Module } from '@nestjs/common';
import { DocumentsController } from './documents/documents.controller';
import { HealthController } from './health.controller';

@Module({
  controllers: [HealthController, DocumentsController],
})
export class AppModule {}
