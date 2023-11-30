output "ecr_repository_url" {
  value = aws_ecr_repository.test_final_block.repository_url
}

output "role_arn" {
  value = aws_iam_role.test_role.arn
}

# Output the ARN of the created SQS queue for reference
output "notification_queue_arn" {
  value = aws_sqs_queue.notification-queue.arn
}

# output "private_key_path" {
#   value = local_file.private_key_file.filename
# }

output "lb_arns" {
  value = [for lb in aws_lb.test-lb : lb.arn]
}