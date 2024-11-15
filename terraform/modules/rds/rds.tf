# modules/rds/main.tf

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "demo-rds-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_security_group" "rds_security_group" {
  name = "demo-rds-sg"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.service_security_group_id]  # Only allow access from ECS tasks
  }
}

resource "aws_db_instance" "postgres" {
  identifier           = "demo-postgres"
  engine              = "postgres"
  engine_version      = "13"
  instance_class      = "db.t3.micro"  # Free tier eligible
  allocated_storage   = 20
  storage_type        = "gp2"
  publicly_accessible = false
  username            = var.db_username
  password            = var.db_password
  
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  
  skip_final_snapshot    = true  # For demo purposes
}

