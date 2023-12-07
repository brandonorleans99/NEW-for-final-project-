  resource "tls_private_key" "Priv-KP" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

 resource "aws_key_pair" "testing-public-KP" {
   key_name   = "testing-KP"
  public_key = tls_private_key.Priv-KP.public_key_openssh
  }

resource "local_file" "private_key_file" {
    filename = "testing"
#   filename = "C:/Users/brand/Desktop/Dev Ops apps/Terraform/testing/private-key.pem"
  content  = tls_private_key.Priv-KP.private_key_pem
}

