output "service_security_group_id" {
  value = aws_security_group.service_security_group.id
}

output "application_url" {
  value = "http://${aws_alb.application_load_balancer.dns_name}"
}