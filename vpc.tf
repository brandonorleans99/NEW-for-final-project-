# Configure the AWS Provider
provider "aws" {
  region = "us-west-1"
}

#AWS VPC
resource "aws_vpc" "test-VPC" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true 

  tags = {
    Name = "test-VPC"
  }
}

#public subnets
resource "aws_subnet" "pub-sub" {
  count = 2
  vpc_id                  = aws_vpc.test-VPC.id
  cidr_block              = var.pub_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true 

  tags = {
    Name = "pub-sub ${count.index + 1}"
  }
}

#private subnets
resource "aws_subnet" "priv-sub" {
  count = 2
  vpc_id                  = aws_vpc.test-VPC.id
  cidr_block              = var.priv_subnet_cidr_blocks[count.index]
  availability_zone       = var.availability_zones[count.index] 

  tags = {
    Name = "priv-sub ${count.index + 1}"
  }
}
# #public subnets 1
# resource "aws_subnet" "pub-sub1" {
#   vpc_id     = aws_vpc.test-VPC.id
#   cidr_block = "10.0.1.0/24"

#   tags = {
#     Name = "pub-sub1"
#   }
# }

# #public subnet 2
# resource "aws_subnet" "pub-sub2" {
#   vpc_id     = aws_vpc.test-VPC.id
#   cidr_block = "10.0.2.0/24"

#   tags = {
#     Name = "pub-sub2"
#   }
# }

# #private subnet 1
# resource "aws_subnet" "priv-sub1" {
#   vpc_id     = aws_vpc.test-VPC.id
#   cidr_block = "10.0.3.0/24"

#   tags = {
#     Name = "priv-sub1"
#   }
# }

# #private subnet 2
# resource "aws_subnet" "priv-sub2" {
#   vpc_id     = aws_vpc.test-VPC.id
#   cidr_block = "10.0.4.0/24"

#   tags = {
#     Name = "priv-sub2"
#   }
# }

#internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.test-VPC.id

  tags = {
    Name = "gw"
  }
}

#aws route 
resource "aws_route" "Public-IGW-route" {
  route_table_id         = aws_route_table.pub-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

#public route table 
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.test-VPC.id

  tags = {
    Name = "pub-rt"
  }
}

#private route table
resource "aws_route_table" "priv-rt" {
  vpc_id = aws_vpc.test-VPC.id

  tags = {
    Name = "priv-rt"
  }
}

#public route table association 1 
resource "aws_route_table_association" "pub-rt-assoc-1" {
    count = 2
  subnet_id      = aws_subnet.pub-sub[count.index].id
  route_table_id = aws_route_table.pub-rt.id
}

# #public route table association 2 
# resource "aws_route_table_association" "pub-rt-assoc-2" {
#   subnet_id      = aws_subnet.pub-sub2.id
#   route_table_id = aws_route_table.pub-rt.id
# }

#private route table association 1 
resource "aws_route_table_association" "priv-rt-assoc-1" {
    count = 2
  subnet_id      = aws_subnet.priv-sub[count.index].id
  route_table_id = aws_route_table.priv-rt.id
}

# #private route table association 2 
# resource "aws_route_table_association" "priv-rt-assoc-2" {
#   subnet_id      = aws_subnet.priv-sub1.id
#   route_table_id = aws_route_table.priv-rt.id
# }

