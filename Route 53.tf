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

# # Create an ACM certificate
# resource "aws_acm_certificate" "SSL-cert" {
#   domain_name       = "e-learning.com"
#   validation_method = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# data "aws_acm_certificate_validation" "SSL-cert-validation" {
#   certificate_arn = aws_acm_certificate.SSL-cert.arn
# }