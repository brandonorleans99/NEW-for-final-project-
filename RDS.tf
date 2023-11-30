resource "aws_db_instance" "rds_instance" {
  identifier            = var.rds_identifier
  engine                = var.rds_engine
  instance_class        = var.rds_instance_class
  allocated_storage     = var.allocated_storage
  storage_type          = var.storage_type
  username              = var.rds_username
  password              = var.rds_password
  db_subnet_group_name  = aws_db_subnet_group.my-db-subnet-group.name
  parameter_group_name = aws_db_parameter_group.my-db-parameter-group.name
  publicly_accessible  = true
}

  # DB subnet group
resource "aws_db_subnet_group" "my-db-subnet-group" {
  name       = var.db_subnet_group_name
  subnet_ids = [aws_subnet.priv-sub[0].id, aws_subnet.priv-sub[1].id]
  # subnet_ids = var.db_subnet_ids
}
  
#   # Specify the VPC and subnet group
#   vpc_security_group_ids = [aws_security_group.testing-sg.id]
#   db_subnet_group_name  = "my-db-subnet-group"
#   }

resource "aws_db_parameter_group" "my-db-parameter-group" {
  name        = var.db_parameter_group_name
  family      = var.db_parameter_group_family
  description = "My PostgreSQL Parameter Group"
}
  
resource "aws_route53_health_check" "test-HC" {
  fqdn              = var.health_check_fqdn
  port              = var.health_check_port
  type              = var.health_check_type
  resource_path     = var.health_check_resource_path
  failure_threshold = var.health_check_failure_threshold
  request_interval  = var.health_check_request_interval

  tags = {
    Name = "test-HC"
  }
}

#logs
resource "aws_cloudwatch_log_group" "test-log" {
  name = var.log_group_name

  tags = var.log_group_tags
}

