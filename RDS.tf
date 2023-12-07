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

#postgreSQL security group
resource "aws_security_group" "postgresql-sg" {
  name        = "postgresql-sg"
  description = "RDS security group acts as a virtual firewall for instance to control inbound and outbound traffic"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  # DB subnet group
resource "aws_db_subnet_group" "my-db-subnet-group" {
  name       = var.db_subnet_group_name
  subnet_ids = [aws_subnet.priv-sub[0].id, aws_subnet.priv-sub[1].id]
  # subnet_ids = var.db_subnet_ids
}

resource "aws_db_parameter_group" "my-db-parameter-group" {
  name        = var.db_parameter_group_name
  family      = var.db_parameter_group_family
  description = "My PostgreSQL Parameter Group"
}

#logs
resource "aws_cloudwatch_log_group" "test-log" {
  name = var.log_group_name

  tags = var.log_group_tags
}

