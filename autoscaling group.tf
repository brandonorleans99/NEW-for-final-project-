resource "aws_placement_group" "placement-group" {
  name     = "placement-group"
  strategy = "spread" #A spread (or partition) placement group is a grouping of instances that are each placed on distinct underlying hardware. This provides a higher level of availability by reducing the risk of simultaneous failures affecting all instances.
}

resource "aws_autoscaling_group" "autoscaling-group" {
  name                      = "my autoscaling group"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  placement_group           = aws_placement_group.placement-group.id
  launch_configuration      = aws_launch_configuration.launch-config.name #this must be defined in your code already 
  vpc_zone_identifier       = [aws_subnet.pub-sub[0].id, aws_subnet.pub-sub[1].id]

  initial_lifecycle_hook {
    name                 = "health-check-lifecycle-hook"
    default_result       = "CONTINUE" #The action to take when the lifecycle hook timeout elapses or if an unexpected failure occurs
    heartbeat_timeout    = 2000 #The time, in seconds, that AWS Auto Scaling waits for the lifecycle hook to complete
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

    notification_metadata = jsonencode({
        environment = "production",
        instance_type = "t2.micro"
    })

    #notification_target_arn = aws_sqs_queue.notification-queue.arn #edit this
    #role_arn                = "arn:aws:iam::520131775371:role/test_role"
  
    # propagate_at_launch = true # Specifies whether the tags should be propagated to instances launched in the Auto Scaling Group.
  }

  # #timeouts {
  #   delete = "20m"
  # }
}

resource "aws_launch_configuration" "launch-config" {
  name_prefix               = "launch-config"
  image_id                  = "ami-010f8b02680f80998"  # Replace with your desired AMI ID
  instance_type             = "t2.micro"               # Replace with your desired instance type
  key_name                  = "testing-KP"     # Replace with your key pair name #key-062454330d37addaf
  security_groups           = [aws_security_group.testing-sg.id]  # Replace with your security group IDs
  iam_instance_profile      = aws_iam_instance_profile.instance-profile.name  # Replace with your IAM instance profile name or ARN

  associate_public_ip_address = true
  user_data                 = <<-EOF
                                #!/bin/bash
                                # Additional user data scripts or cloud-init configuration
                                EOF

#    instance_maintenance_policy {
#     min_healthy_percentage = 90
#     max_healthy_percentage = 120
#   }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_sqs_queue" "notification-queue" {
  name = "notification-queue"
  # Additional configuration for your SQS queue, if needed
}

resource "aws_iam_instance_profile" "instance-profile" {
  name = "instance-profile"  # Updated instance profile name
  role = "arn:aws:iam::520131775371:role/test_role"
}

resource "null_resource" "depends-on-asg" {
  triggers = {
    asg_dependency = aws_autoscaling_group.autoscaling-group.name
  }

  depends_on = [aws_lb_target_group_attachment.TG-attachment]
}
