resource "aws_security_group" "testing-sg" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = aws_vpc.test-VPC.id

  dynamic "ingress" {
    for_each = var.security_group_ingress_rules

    content {
      description      = ingress.value["description"]
      from_port        = ingress.value["from_port"]
      to_port          = ingress.value["to_port"]
      protocol         = ingress.value["protocol"]
      cidr_blocks      = ingress.value["cidr_blocks"]
    }
  }
}