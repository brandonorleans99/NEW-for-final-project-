#VPC
variable "vpc_id" {
  description = "ID of the VPC where subnets will be created"
  type        = string
  default = "aws_vpc.test-VPC.id"
}

variable "availability_zones" {
  description = "List of Availability Zones for subnets"
  type        = list(string)
  default     = ["us-west-1b", "us-west-1c"]
}

variable "pub_subnet_cidr_blocks" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24",]
}

variable "priv_subnet_cidr_blocks" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = [ "10.0.3.0/24", "10.0.4.0/24"]
}

variable "security_group" {
  type = string
  default = "aws_security_group.testing-sg.id"
}

#ECR
variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
  default     = "test_final_repo"
}

#ECS cluster
variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "cluster"
}

variable "ecs_cluster_setting_name" {
  description = "Name of the ECS cluster setting"
  type        = string
  default     = "containerInsights"
}

variable "ecs_cluster_setting_value" {
  description = "Value of the ECS cluster setting"
  type        = string
  default     = "enabled"
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
  default     = "ecs-service"
}

variable "ecs_desired_count" {
  description = "Desired count for the ECS service"
  type        = number
  default     = 4
}

variable "ecs_deployment_minimum_healthy_percent" {
  description = "Minimum healthy percent for ECS service deployment"
  type        = number
  default     = 100
}

variable "ecs_capacity_provider" {
  description = "Capacity provider for the ECS service"
  type        = string
  default     = "FARGATE_SPOT"
}

variable "ecs_capacity_provider_weight" {
  description = "Weight for the ECS capacity provider strategy"
  type        = number
  default     = 4
}

variable "ecs_service_launch_type" {
  description = "Launch type for the ECS service"
  type        = string
  default     = "FARGATE"
}

#IAM Role
variable "role_name" {
  type    = string
  default = "test_role"
}

variable "policy_name" {
  type    = string
  default = "test_policy"
}

variable "policy_description" {
  type    = string
  default = "My test policy"
}

variable "policy_actions" {
  type    = list(string)
  default = ["ec2:Describe*"]
}

variable "tags" {
  type    = map(string)
  default = {
    "tag-key"   = "tag-value",
  }
}


#RDS
variable "rds_identifier" {
  description = "Identifier for the RDS instance"
  default     = "my-rds-instance"
}

variable "rds_engine" {
  description = "Database engine for the RDS instance"
  default     = "postgres"
}

variable "rds_instance_class" {
  description = "Instance type for the RDS instance"
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Storage capacity in GB for the RDS instance"
  default     = 20
}

variable "storage_type" {
  description = "Storage type for the RDS instance"
  default     = "standard"
}

variable "rds_username" {
  description = "Master username for the RDS instance"
  default     = "finalproject"
}

variable "rds_password" {
  description = "Master password for the RDS instance"
  default     = "finalproject123"
}

variable "db_subnet_group_name" {
  description = "Name for the DB subnet group"
  default     = "my-db-subnet-group"
}

variable "db_subnet_ids" {
  description = "Subnet IDs for the DB subnet group"
  default     = ["aws_subnet.priv-sub[0].id", "aws_subnet.priv-sub[1].id"]
}

variable "db_parameter_group_name" {
  description = "Name for the DB parameter group"
  default     = "my-db-parameter-group"
}

variable "db_parameter_group_family" {
  description = "Family for the DB parameter group"
  default     = "postgres15"
}

variable "health_check_fqdn" {
  description = "FQDN for the health check"
  default     = "brando.com"
}

variable "health_check_port" {
  description = "Port for the health check"
  default     = 80
}

variable "health_check_type" {
  description = "Type for the health check"
  default     = "HTTP"
}

variable "health_check_resource_path" {
  description = "Resource path for the health check"
  default     = "/"
}

variable "health_check_failure_threshold" {
  description = "Failure threshold for the health check"
  default     = "5"
}

variable "health_check_request_interval" {
  description = "Request interval for the health check"
  default     = "30"
}

variable "log_group_name" {
  description = "Name for the CloudWatch Log Group"
  default     = "test-log"
}

variable "log_group_tags" {
  description = "Tags for the CloudWatch Log Group"
  default     = {
    Environment = "development"
    Application = "serviceA"
  }
}

#security group
variable "security_group_name" {
  description = "Name for the security group"
  default     = "testing-sg"
}

variable "security_group_description" {
  description = "Description for the security group"
  default     = "Allow TLS inbound traffic"
}

variable "security_group_vpc_id" {
  description = "VPC ID for the security group"
  default     = "aws_vpc.test-VPC.id"
}

variable "security_group_ingress_rules" {
  description = "List of ingress rules for the security group"
  default     = [
    {
      description = "TLS from VPC"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "TLS from VPC"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
}

variable "task_family" {
  description = "Family name for the ECS task definition"
  default     = "task_definition"
}

variable "task_network_mode" {
  description = "Network mode for the ECS task definition"
  default     = "awsvpc"
}

variable "task_requires_compatibilities" {
  description = "List of compatibility requirements for the ECS task definition"
  default     = ["FARGATE"]
}

variable "task_cpu" {
  description = "CPU setting at the task level for the ECS task definition"
  default     = "256"
}

variable "task_memory" {
  description = "Memory setting at the task level for the ECS task definition"
  default     = "1024"
}

variable "task_execution_role_arn" {
  description = "ARN of the IAM role used by the ECS task definition"
  default     = "aws_iam_role.test_role.arn"
}

variable "container_definitions" {
  description = "List of container definitions for the ECS task definition"
  default     = [
    {
      name      = "final_project_container"
      image     = "520131775371.dkr.ecr.us-west-1.amazonaws.com/test_final_repo"
      essential = true
      execution_role_arn = ""
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    },
    {
      name      = "final_project_container2"
      image     = "520131775371.dkr.ecr.us-west-1.amazonaws.com/test_final_repo"
      essential = true
      portMappings = [
        {
          containerPort = 443
          hostPort      = 443
        }
      ]
    }
  ]
}

#task definition
variable "task_volume" {
  description = "Volume configuration for the ECS task definition"
  default     = [
    {
      name      = "service-storage"
      # host_path = "/ecs/service-storage"
    }
  ]
}