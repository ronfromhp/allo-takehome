# Doctor API Service

A RESTful API service for managing doctor information, built with NestJS and deployed on AWS infrastructure.

## API Documentation

All endpoints require authentication via API key in the `X-API-Key` header.

### POST /doctors
Creates a new doctor record.

**Request**
```json
{
  "email": "doctor@example.com",
  "password": "securePassword123",
  "firstName": "John",
  "lastName": "Doe"
}
```

**Response** (201 Created)
```json
{
  "email": "doctor@example.com",
  "firstName": "John",
  "lastName": "Doe",
  "doctorCredentialId": 1
}
```


### GET /doctors
Retrieves a list of all doctors.

**Response** (200 OK)
```json
[
  {
    "email": "doctor@example.com",
    "firstName": "John",
    "lastName": "Doe",
    "doctorCredentialId": 1
  }
]
```

### Error Responses
- 400 Bad Request: Invalid input data
- 401 Unauthorized: Invalid or missing API key
- 403 Forbidden: Credentials taken

# Project Setup

## Prerequisites

Make sure you have the following installed on your machine:
- Node.js (>= 14.x)
- npm (>= 6.x)
- Docker
- AWS CLI
- Terraform

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/ronfromhp/allo-takehome.git
    cd allo-takehome/app
    ```

2. Install the dependencies:
    ```bash
    npm install
    ```

## Running the Project Locally

1. Create a `.env` file in the `app/` directory:
     ```env
     DATABASE_URL=postgresql://postgres:123@localhost:5432/allo
     API_KEY=<your-api-key-here>
     ```

2. Start the application in development mode:
    ```bash
    npm run db:dev:restart #run it once for the first time to apply migrations and start afresh
    npm run start:dev
    ```

3. Test the API with your key:
    ```bash
    curl -H "X-API-Key: <your-api-key-here>" http://localhost:3000/doctors
    ```

## Running Tests

1. Create a `.env.test` file in the `app/` directory:
     ```env
     DATABASE_URL=postgresql://postgres:123@localhost:5433/allo
     API_KEY=<your-api-key-here>
     ```

2. Run the end-to-end tests:
    ```bash
    npm run test:e2e
    ```

This will use the configuration from your `.env.test` file to run the tests against a separate test database.

# Infrastructure

## AWS Components
- **ECS Fargate**: Containerized application hosting
- **RDS**: PostgreSQL database
- **Application Load Balancer**: Traffic distribution
- **CloudWatch**: Availability monitoring
- **VPC**: Isolated network environment

## Provisioning AWS Resources

1. Configure the AWS CLI if not already authenticated:
    ```bash
    aws configure
    ```

2. Navigate to the Terraform directory:
    ```bash
    cd ../terraform
    ```

3. Create a `terraform.tfvars` file in the terraform directory:
     ```hcl
     api_key = "<your-api-key-here>"
     ```
4. Initialize Terraform:
    ```bash
    terraform init
    ```

5. Apply the Terraform configuration to provision the resources:
    ```bash
    terraform apply -auto-approve
    ```

## Deployment


Run the deployment script to build, push, and deploy the application:

```bash
cd ..
./deploy.sh
```

The script will output the URL of the deployed application. Verify the deployment using:

```bash
curl -H "X-API-Key: <your-api-key-here>" your-deployed-url/doctors
```

## Cleaning Up

To destroy the provisioned AWS resources and avoid incurring costs, run:

```bash
cd terraform
terraform destroy -auto-approve
```