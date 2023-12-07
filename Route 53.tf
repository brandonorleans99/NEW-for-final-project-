# resource "aws_route53_zone" "R53-zone" {
#   name = "R53-zone"
# }

# # Create a DNS record for ACM certificate validation
# resource "aws_route53_record" "e-learning" {
#   zone_id = aws_route53_zone.R53-zone.zone_id
#   name    = "e-learning.com"
#   type    = "A"
#   ttl     = "300"
# #   records = [aws_acm_certificate.SSL-cert.domain_validation_options.0.resource_record_value]
#  records = [aws_acm_certificate.SSL-cert.domain_validation_options[0].resource_record_value] #(unsure)
# }


resource "aws_route53_health_check" "test-HC" {
  fqdn              = var.health_check_fqdn
  port              = var.health_check_port
  type              = var.health_check_type
  resource_path     = var.health_check_resource_path
  failure_threshold = var.health_check_failure_threshold
  request_interval  = var.health_check_request_interval

  tags = {
    Name = "test-HC"
  }
}