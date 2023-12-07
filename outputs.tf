output "available_azs" {
  value = data.aws_availability_zones.available.names
}

output "vpc_id" {
  value = aws_vpc.test-VPC.id
}

output "public_subnet_ids" {
  value = aws_subnet.pub-sub[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.priv-sub[*].id
}

output "security_group_id" {
  value = aws_security_group.testing-sg.id
}

#double check first before adding 
# output "domain_name" {
#   value = var.domain_name
# }

# output "certificate_arn" {
# aws_acm_certificate.acm_certificate.arn
# }


output "ecr_repository_url" {
  value = aws_ecr_repository.test_final_block.repository_url
}

output "role_arn" {
  value = aws_iam_role.test_role.arn
}

# # Output the ARN of the created SQS queue for reference
# output "notification_queue_arn" {
#   value = aws_sqs_queue.notification-queue.arn
# }

# output "private_key_path" {
#   value = local_file.private_key_file.filename
# }

# output "lb_arns" {
#   value = [for lb in aws_lb.test-lb : lb.arn]
# }

# # output "elb-dns-name" {
# #      value = [for lb in aws_lb.test-lb : lb.dns_name]
# # }

# output "elb-dns-name" {
#   value = aws_lb.test-lb.dns_name
# }

