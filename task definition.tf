resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.task_family
  network_mode             = var.task_network_mode
  requires_compatibilities = var.task_requires_compatibilities

  cpu    = var.task_cpu
  memory = var.task_memory

  execution_role_arn = aws_iam_role.test_role.arn

  container_definitions = jsonencode(var.container_definitions)

  volume {
    name      = var.task_volume[0]["name"]
    # host_path = var.task_volume[0]["host_path"]

    # name      = "service-storage"
    # # host_path = "/ecs/service-storage"
  }
}