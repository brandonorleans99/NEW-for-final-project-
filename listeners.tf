#load balace listener 1
resource "aws_lb_listener" "LB-listener" {
  count             = 2
  load_balancer_arn = aws_lb.test-lb[count.index].arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test-TG[count.index].arn
  }
}

# #load balace listener 2
# resource "aws_lb_listener" "LB-listener2" {
#   load_balancer_arn = aws_lb.test-lb2.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.test-TG2.arn
#   }
# }

#Target groups 
resource "aws_lb_target_group" "test-TG" {
  count    = 2
  name     = "test-TG${count.index + 1}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.test-VPC.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    port                = "traffic-port"
  }
}

# #Target groups 2
# resource "aws_lb_target_group" "test-TG2" {
#   name     = "test-TG2"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.test-VPC.id

#     health_check {
#     path                = "/"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     port                = "traffic-port"
#   }
# }

#target group attachment 1
resource "aws_lb_target_group_attachment" "TG-attachment" {
  count            = 2
  target_group_arn = aws_lb_target_group.test-TG[count.index].arn
  target_id        = aws_instance.test-instance[count.index].id
  port             = 80
}

# #target group attachment 2
# resource "aws_lb_target_group_attachment" "TG-attachment2" {
#   target_group_arn = aws_lb_target_group.test-TG2.arn
#   target_id        = aws_instance.test-instance2.id
#   port             = 80
# }

# Load Balancer Listener Rules for LB-listener
resource "aws_lb_listener_rule" "listener-rule" {
  count        = 2
  listener_arn = aws_lb_listener.LB-listener[count.index].arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test-TG[count.index].arn
  }

  condition {
    path_pattern {
      values = ["/app${count.index + 1}/*"]
    }
  }
}