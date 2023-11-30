# #resource "aws_key_pair" "testing-KP" {
#   key_name   = "testing-KP"
#   public_key = tls_private_key.rsa.public_key_openssh
#   }

#   resource "tls_private_key" "rsa" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "local_file" "private_key_file" {
#   filename = "key pairs" #/desktop/dev ops apps/key pairs/private-key.pem"
#   content  = tls_private_key.rsa.private_key_pem
# }
