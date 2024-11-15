#!/bin/bash
set -e

# Get account ID and region
ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
REGION=$(aws configure get region)

# Navigate to the Terraform directory and get outputs
cd terraform
REPO_NAME=$(terraform output -raw repository_url | sed 's#.*/##')
REPO_URL=$(terraform output -raw repository_url)
CLUSTER_NAME=$(terraform output -raw cluster_name)
SERVICE_NAME=$(terraform output -raw service_name)
cd ..

IMAGE_TAG="latest"

# Authenticate Docker to ECR
echo "Logging into ECR..."
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin "$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com"

# Navigate to the app directory, build, tag, and push the image
cd app
docker build -t "$REPO_NAME" .
docker tag "$REPO_NAME:latest" "$REPO_URL:$IMAGE_TAG"
docker push "$REPO_URL:$IMAGE_TAG"
cd ..

# Update ECS service
aws ecs update-service --cluster $CLUSTER_NAME --service $SERVICE_NAME --force-new-deployment --region $REGION > /dev/null

cd terraform
echo "Deployment complete. ECS service is running at: $(terraform output -raw application_url)"
