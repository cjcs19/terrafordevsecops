locals {
  env         = "general"
  module_name = "bastion"
}

#data "aws_ami" "amazon_linux" {
#  most_recent = true
#
#  owners = ["306192109948"]
#
#  filter {
#    name = "name"
#
#    values = [
#      "app-cajecasu-1630595394",
#    ]
#  }
#
#}

#Bastion SSH
resource "aws_instance" "bastion" {
  ami                         = var.amiid #data.aws_ami.amazon_linux.id
  key_name                    = aws_key_pair.bastion_key.key_name
  instance_type               = "t2.micro"
  subnet_id                   =  var.subnet_id
  vpc_security_group_ids             = [var.sg-bastion]

  tags = {
    Name = "BastionSsh"
  }
  
  associate_public_ip_address = true
}


resource "aws_key_pair" "bastion_key" {
  key_name   = "cursodevsecops"
  public_key = var.public_key
}


