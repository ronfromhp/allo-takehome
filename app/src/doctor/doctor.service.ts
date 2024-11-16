import { ForbiddenException, Injectable } from "@nestjs/common";
import { PrismaService } from "../prisma/prisma.service";
import { DoctorDto } from "./dto";
import * as argon from 'argon2';

@Injectable()
export class DoctorService {
    constructor(private prisma: PrismaService) { }

    async create(dto: DoctorDto) {
        // generate a hash of the password
        const hash = await argon.hash(dto.password);

        //check if the email already exists
        try {
            //save the user to the database
            const doctor = await this.prisma.doctor.create({
                data: {
                    email: dto.email,
                    password: hash,
                    firstName: dto.firstName,
                    lastName: dto.lastName,
                },
            });

            const { password, ...result } = doctor;
            return result;
        } catch (error) {
            if (error.code === 'P2002') {
                throw new ForbiddenException('Credentials taken');
            }
            throw error;
        }
    }

    async findAll() {
        const doctors = await this.prisma.doctor.findMany();
        return doctors.map(({ password, ...doctor }) => doctor);
    }
}