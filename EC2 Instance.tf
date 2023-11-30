resource "aws_instance" "test-instance" {
  count         = 2
  ami           = "ami-010f8b02680f80998"
  instance_type = "t2.micro"
  key_name      = "testing-KP"
  vpc_security_group_ids = [aws_security_group.testing-sg.id]
  subnet_id              = aws_subnet.pub-sub[count.index].id # Make sure it's a public subnet in the same VPC


  tags = {
    Name = "test-instance${count.index + 1}"
  }
}

# resource "aws_instance" "test-instance2" {
#   ami           = "ami-010f8b02680f80998"
#   instance_type = "t2.micro"
#   key_name      = "testing-KP"
#   vpc_security_group_ids = [aws_security_group.testing-sg.id]
#   subnet_id              = aws_subnet.pub-sub[1].id

#   tags = {
#     Name = "test-instance2"
#   }
# }

