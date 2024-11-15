variable "service_security_group_id" {
    description = "ECS Service Security Group ID"
    type        = string
}

variable "db_username" {
    description = "Database Username"
    type        = string
}

variable "db_password" {
    description = "Database Password"
    type        = string
}

variable "subnet_ids" {
  type = list(string)
  description = "List of subnet IDs for RDS"
}
