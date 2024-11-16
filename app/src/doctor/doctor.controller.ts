import { Body, Controller, Get, Post, UseGuards } from "@nestjs/common";
import { DoctorService } from "./doctor.service";
import { DoctorDto } from "./dto";
import { AuthGuard } from "@nestjs/passport";

@Controller('doctors')
@UseGuards(AuthGuard('api-key'))
export class DoctorController {
    constructor(private doctorService: DoctorService) { }

    @Post()
    create(@Body() dto: DoctorDto) {
        return this.doctorService.create(dto);
    }

    @Get()
    findAll() {
        return this.doctorService.findAll();
    }
}