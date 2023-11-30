resource "aws_ecr_repository" "test_final_block" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"

#this will let us know if there are errors or vulnerabilities
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    env = "dev"
    name = var.repository_name
  }
}