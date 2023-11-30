# resource "aws_ecs_fargate_profile" "my_fargate_profile" {
#   name                 = "my-fargate-profile"
#   cluster              = aws_ecs_cluster.my_cluster.id
#   subnet_ids           = aws_subnet.public_subnet[*].id
#   security_group_names = [aws_security_group.public_sg.name]

#   fargate_profile_selector {
#     container_name = "my-container"
#     task_definition_arns = [
#       aws_ecs_task_definition.my_task_definition.arn,
#     ]
#   }
# }