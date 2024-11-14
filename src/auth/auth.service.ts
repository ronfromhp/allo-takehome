import { Injectable } from "@nestjs/common";

@Injectable({})
export class AuthService {
    signup() {
        return "I'm a signed up";
    }
    signin() {
        return "I'm a signed in";
    }
}