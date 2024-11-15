
output "repository_url" {
  value = module.ecrRepo.repository_url
}

output "cluster_name" {
  value = local.demo_app_cluster_name
}

output "service_name" {
  value = local.demo_app_service_name
}

output "application_url" {
  value = module.ecsCluster.application_url
}