import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { DoctorModule } from './doctor/doctor.module';
import { PrismaModule } from './prisma/prisma.module';

@Module({
  imports: [AuthModule, DoctorModule, PrismaModule],
})
export class AppModule {}
