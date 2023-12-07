resource "aws_autoscaling_group" "autoscaling-group" {
  name                      = "my autoscaling group"
  max_size                  = 4
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.launch-config.name #this must be defined in your code already 
  vpc_zone_identifier       = aws_subnet.pub-sub[*].id
}

resource "aws_launch_configuration" "launch-config" {
  name_prefix               = "launch-config"
  image_id                  = "ami-010f8b02680f80998"  # Replace with your desired AMI ID
  instance_type             = "t2.micro"               # Replace with your desired instance type
  key_name                  = "testing-KP"     # Replace with your key pair name #key-062454330d37addaf
  security_groups           = [aws_security_group.testing-sg.id]  # Replace with your security group IDs
  # iam_instance_profile      = aws_iam_instance_profile.instance-profile.name  # Replace with your IAM instance profile name or ARN

  associate_public_ip_address = true
 
  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_sqs_queue" "notification-queue" {
#   name = "notification-queue"
#   # Additional configuration for your SQS queue, if needed
# }

# resource "aws_iam_instance_profile" "instance-profile" {
#   name = "instance-profile"  # Updated instance profile name
#   role = "arn:aws:iam::520131775371:role/test_role"
# }


