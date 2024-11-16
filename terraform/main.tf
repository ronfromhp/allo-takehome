terraform {
  required_version = "~> 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

module "vpc" {
  source             = "./modules/vpc"
  availability_zones = local.availability_zones
}

module "ecrRepo" {
  source = "./modules/ecr"

  ecr_repo_name = local.ecr_repo_name
}

module "rdsDatabase" {
  source = "./modules/rds"

  db_username               = "username"
  db_password               = "password"
  service_security_group_id = module.ecsCluster.service_security_group_id
  subnet_ids                = module.vpc.subnet_ids
}

module "ecsCluster" {
  source = "./modules/ecs"

  demo_app_cluster_name = local.demo_app_cluster_name
  availability_zones    = local.availability_zones

  demo_app_task_famliy         = local.demo_app_task_famliy
  ecr_repo_url                 = module.ecrRepo.repository_url
  container_port               = local.container_port
  demo_app_task_name           = local.demo_app_task_name
  ecs_task_execution_role_name = local.ecs_task_execution_role_name

  database_url = module.rdsDatabase.database_url
  api_key = var.api_key

  application_load_balancer_name = local.application_load_balancer_name
  target_group_name              = local.target_group_name
  demo_app_service_name          = local.demo_app_service_name
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids
}