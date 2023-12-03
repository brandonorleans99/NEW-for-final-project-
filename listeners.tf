#load balace listener 
resource "aws_lb_listener" "LB-listener" {
  count             = 2
  load_balancer_arn = aws_lb.test-lb[count.index].arn
  port              = "80"
  protocol          = "HTTP"

  #ssl_policy      = "ELBSecurityPolicy-2016-08"
  # certificate_arn = aws_acm_certificate.SSL-cert.arn
  

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test-TG[count.index].arn
  }
}

#Target groups 
resource "aws_lb_target_group" "test-TG" {
  count           = 2
  name            = "test-TG${count.index + 1}"
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
  target_group_arn = aws_lb_target_group.test-TG[count.index].arn
  target_id        = aws_instance.test-instance[count.index].id
  port             = 80
}

# Load Balancer Listener Rules for LB-listener
resource "aws_lb_listener_rule" "listener-rule" {
  count        = 2
  listener_arn = aws_lb_listener.LB-listener[count.index].arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test-TG[count.index].arn
  }

    dynamic "condition" {
    for_each = aws_instance.test-instance[*].id
    content {
      host_header {
        values = [aws_instance.test-instance[count.index].public_ip]
      }
  # condition {
  #   path_pattern {
  #     values = ["/app${count.index + 1}/*"]
    }
  }
}