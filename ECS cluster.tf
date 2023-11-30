resource "aws_ecs_cluster" "cluster" {
  name = var.ecs_cluster_name

  setting {
    name  = var.ecs_cluster_setting_name
    value = var.ecs_cluster_setting_value
  }
}

resource "aws_ecs_service" "ecs_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.cluster.name
  task_definition = aws_ecs_task_definition.task_definition.arn
  desired_count   = var.ecs_desired_count
  deployment_minimum_healthy_percent = var.ecs_deployment_minimum_healthy_percent

  capacity_provider_strategy {
    capacity_provider = var.ecs_capacity_provider
    weight            = var.ecs_capacity_provider_weight
  }

  network_configuration {
    subnets          = [aws_subnet.priv-sub[0].id, aws_subnet.priv-sub[1].id]  # Replace with your private subnet IDs. Always st
    security_groups  = [aws_security_group.testing-sg.id]  # Replace with your security group IDs
  }
}