variable "vpc_id" {
  type = string
  description = "VPC ID to deploy resources in"
}

variable "subnet_ids" {
  type = list(string)
  description = "List of subnet IDs for the ECS service"
}

variable "demo_app_cluster_name" {
  description = "ECS Cluster Name"
  type        = string
}

variable "availability_zones" {
  description = "ap-south-1 AZs"
  type        = list(string)
}

variable "demo_app_task_famliy" {
  description = "ECS Task Family"
  type        = string
}

variable "ecr_repo_url" {
  description = "ECR Repo URL"
  type        = string
}

variable "container_port" {
  description = "Container Port"
  type        = number
}

variable "demo_app_task_name" {
  description = "ECS Task Name"
  type        = string
}

variable "ecs_task_execution_role_name" {
  description = "ECS Task Execution Role Name"
  type        = string
}

variable "application_load_balancer_name" {
  description = "ALB Name"
  type        = string
}

variable "target_group_name" {
  description = "ALB Target Group Name"
  type        = string
}

variable "demo_app_service_name" {
  description = "ECS Service Name"
  type        = string
}

variable "database_url" {
  description = "Database URL"
  type        = string
}

variable "api_key" {
  description = "API Key"
  type        = string
}