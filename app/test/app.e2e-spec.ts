import { Test } from "@nestjs/testing";
import { AppModule } from "../src/app.module";
import { ValidationPipe, INestApplication } from "@nestjs/common";
import * as pactum from 'pactum';
import { ConfigService } from "@nestjs/config";

describe('App e2e', () => {
  let app: INestApplication;
  let config = new ConfigService();
  let apiKey = config.get<string>('API_KEY');
  beforeAll(async () => {
    const moduleRef =
      await Test.createTestingModule({
        imports: [AppModule],
      }).compile();

    app = moduleRef.createNestApplication();
    app.useGlobalPipes(new ValidationPipe({
      whitelist: true,
    }));
    await app.init();
    await app.listen(3000);
    pactum.request.setBaseUrl('http://localhost:3000');
    pactum.request.setDefaultHeaders({
      'X-API-KEY': apiKey
    });
  });

  afterAll(async () => {
    app.close();
  });

  describe('Doctor', () => {
    const dto = {
      email: 'doc@mail.com',
      password: 'password',
      firstName: 'doc',
      lastName: 'tor',
    };
    describe('create', () => {
      it('should create a doctor', () => {
        return pactum.spec()
          .post('/doctors')
          .withBody(dto)
          .expectStatus(201)
      });
      it('should throw error if email is taken', () => {
        return pactum.spec()
          .post('/doctors')
          .withBody(dto)
          .expectStatus(403)
      });
      it('should throw error if email is invalid', () => {
        return pactum.spec()
          .post('/doctors')
          .withBody({ ...dto, email: 'invalid-email' })
          .expectStatus(400)
      });
      it('should throw error if password is invalid', () => {
        return pactum.spec()
          .post('/doctors')
          .withBody({ ...dto, password: '' })
          .expectStatus(400)
      });
    });
    describe('findAll', () => {
      it('should return all doctors', () => {
        return pactum.spec()
          .get('/doctors')
          .expectStatus(200)
      });
    });
  });
});