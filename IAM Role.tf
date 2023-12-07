# IAM role
resource "aws_iam_role" "test_role" {
  name             = var.role_name
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Sid    = "",
        Principal = {
          Service = "ec2.amazonaws.com",
        },
      },
    ],
  })

  tags = {
    tag-key = "tag-value",
  }
}

# IAM policy
resource "aws_iam_policy" "test_policy" {
  name        = var.policy_name
  path        = "/"
  description = var.policy_description #policy for launching EC2 instances

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["ec2:Describe*",
                    "ec2:RunInstances",
                    "ec2:DescribeInstances",
                    "ec2:TerminateInstances",
                    "ec2:DetachNetworkInterface",
                    "ec2:DescribeNetworkInterfaces"],
        Effect   = "Allow",
        Resource = "*",
      },
    ],
  })
}

# Attach the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "test-role-attachment" {
  # policy_arn = aws_iam_policy.test_policy.arn
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.test_role.name
}