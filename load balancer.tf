resource "aws_lb" "test-lb" {
  count             = 2
  name              = "test-lb-${count.index + 1}"
  internal          = false
  ip_address_type   = "ipv4"
  load_balancer_type = "application"
  subnets           = [aws_subnet.pub-sub[0].id, aws_subnet.pub-sub[1].id]
  security_groups   = [aws_security_group.testing-sg.id]
  enable_deletion_protection = false
  enable_cross_zone_load_balancing = true
}

