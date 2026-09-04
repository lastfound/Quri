import { Injectable } from '@nestjs/common';
import { PrismaService } from './prisma/prisma.service';

@Injectable()
export class AppService {
  constructor(private readonly prisma: PrismaService) {}

  getHello(): string {
    return 'Selamat datang di API Backend Quri (Gamifikasi Qur\'an)! 🚀';
  }

  async checkDatabaseHealth() {
    try {
      await this.prisma.$queryRaw`SELECT 1`;
      return {
        status: 'OK',
        database: 'Connected to PostgreSQL successfully',
        timestamp: new Date().toISOString(),
      };
    } catch (error: any) {
      return {
        status: 'ERROR',
        database: 'Failed to connect to PostgreSQL',
        error: error.message,
        timestamp: new Date().toISOString(),
      };
    }
  }
}
