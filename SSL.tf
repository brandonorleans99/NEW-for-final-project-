# Create an ACM certificate
resource "aws_acm_certificate" "SSL-cert" {
  domain_name       = "e-learning.com"
  validation_method = "DNS"

    tags = {
    Environment = "prod"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# data "aws_acm_certificate_validation" "SSL-cert-validation" {
#   certificate_arn = aws_acm_certificate.SSL-cert.arn
# }