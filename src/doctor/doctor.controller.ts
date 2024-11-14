import { Body, Controller, Get, Post } from "@nestjs/common";
import { DoctorService } from "./doctor.service";
import { DoctorDto } from "./dto";

@Controller('doctors')
export class DoctorController {
    constructor(private doctorService: DoctorService) {}

    @Post()
    create(@Body() dto: DoctorDto) {
        return this.doctorService.create(dto);
    }

    @Get()
    findAll() {
        return this.doctorService.findAll();
    }
}