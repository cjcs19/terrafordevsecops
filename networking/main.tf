locals {
  env         = "testpub"
  module_name = "networking"
}
####################################################################
# VPC
####################################################################
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${local.env}_vpc"
    App  = var.app
  }
}
####################################################################
# Public Subnets
####################################################################
resource "aws_subnet" "subnet_pub_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_pub_a_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = "${local.env}_snet_pub_a"
    App  = var.app
  }
}

####################################################################
# ELASTIC IPs
####################################################################
resource "aws_eip" "eip_ngw1" {
  vpc = true
  tags = {
    Name = "${local.env}_eip_ngw"
    App  = var.app
  }
}
####################################################################
# GATEWAYS
####################################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${local.env}_igw"
    App  = var.app
  }
}

resource "aws_nat_gateway" "ngw1" {
  allocation_id = aws_eip.eip_ngw1.id
  subnet_id     = aws_subnet.subnet_pub_a.id
  tags = {
    Name = "${local.env}_ngw"
    App  = var.app
  }
}
####################################################################
# ROUTE TABLES
####################################################################
resource "aws_route_table" "routing_table_pub" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${local.env}_rt_pub"
    App  = var.app
  }
}
####################################################################
# ROUTE TABLES ASSOCIATION
####################################################################
resource "aws_route_table_association" "route_table_association_pub_a" {
  subnet_id      = aws_subnet.subnet_pub_a.id
  route_table_id = aws_route_table.routing_table_pub.id
}

