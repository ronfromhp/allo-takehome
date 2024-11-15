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

1. Set up the environment variables:
    - Create a `.env` file in the root directory of the project.
    - Add the following environment variables to the `.env` file (for local development only):
        ```env
        DATABASE_URL=postgresql://postgres:123@localhost:5432/allo?schema=public
        ```

2. Start the database using Docker:
    ```bash
    npm run db:dev:restart
    ```

3. Start the application in development mode:
    ```bash
    npm run start:dev
    ```

## Provisioning AWS Resources

1. Navigate to the Terraform directory:
    ```bash
    cd ../terraform
    ```

2. Initialize Terraform:
    ```bash
    terraform init
    ```

3. Apply the Terraform configuration to provision the resources:
    ```bash
    terraform apply -auto-approve
    ```

## Deploying the Application

### Automated Deployment Script

Run the deployment script to build, push, and deploy the application:

```bash
../deploy.sh
```

### Cleaning Up

To destroy the provisioned AWS resources and avoid incurring costs, run:

```bash
terraform destroy -auto-approve
```