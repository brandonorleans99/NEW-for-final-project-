#load balancer
resource "aws_lb" "test-lb" {
  name              = var.load_balancer_name
  internal          = false
  ip_address_type   = "ipv4"
  load_balancer_type = "application"
  subnets           = [aws_subnet.pub-sub[0].id, aws_subnet.pub-sub[1].id]
  security_groups   = [aws_security_group.testing-sg.id]
  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true
}

#load balace listener 
resource "aws_lb_listener" "LB-listener" {
  load_balancer_arn = aws_lb.test-lb.arn
  port              = "80"
  protocol          = "HTTP"  

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test-TG.arn
  }
}  

#Target groups 
resource "aws_lb_target_group" "test-TG" {
  name            = "test-TG"
  port            = 80
  protocol        = "HTTP"
  vpc_id          = aws_vpc.test-VPC.id
  target_type     = "instance"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
    port                = "80" #"traffic-port"
  }
}

#target group attachment 
resource "aws_lb_target_group_attachment" "TG-attachment" {
  count            = length(aws_instance.test-instance)
  target_group_arn = aws_lb_target_group.test-TG.arn
  target_id        = aws_instance.test-instance[count.index].id
  port             = 80
}

# Load Balancer Listener Rules for LB-listener
# resource "aws_lb_listener_rule" "listener-rule" {
#   listener_arn = aws_lb_listener.LB-listener.arn
#   priority     = 100

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.test-TG.arn
#   }

#     dynamic "condition" {
#     for_each = aws_instance.test-instance[*].id
#     content {
#       host_header {
#         values = [aws_instance.test-instance[count.index].public_ip]
#       }
#     }
#   }
# }




