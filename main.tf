# Configure the AWS Provider
provider "aws" {
  region = "us-west-1"
}

data "aws_availability_zones" "available" {
  state = "available"
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

#private route table association 1 
resource "aws_route_table_association" "priv-rt-assoc-1" {
    count = 2
  subnet_id      = aws_subnet.priv-sub[count.index].id
  route_table_id = aws_route_table.priv-rt.id
}

