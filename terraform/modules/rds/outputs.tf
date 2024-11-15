# Output the database connection string
output "database_url" {
  value = "postgres://${aws_db_instance.postgres.username}:${aws_db_instance.postgres.password}@${aws_db_instance.postgres.endpoint}/allo"
  sensitive = true
}

output "database_host" {
  description = "RDS instance hostname"
  value       = aws_db_instance.postgres.endpoint
  sensitive   = true
}

output "database_port" {
  description = "RDS instance port"
  value       = aws_db_instance.postgres.port
  sensitive   = true
}

output "database_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.postgres.username
  sensitive   = true
}