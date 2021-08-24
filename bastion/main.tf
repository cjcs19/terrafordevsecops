locals {
  env         = "general"
  module_name = "bastion"
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["306192109948"]

  filter {
    name = "name"

    values = [
      "app-cesar-1629766623",
    ]
  }
  
}

#Bastion SSH
resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.amazon_linux.id
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


