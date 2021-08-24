####################################################################
# Terraform Backend
####################################################################
provider "aws" {
  region = "us-east-1"
  # assume_role {
  # role_arn     = var.trusted_role
  # session_name = "terraform"
  # external_id  = "%PUT_HERE_EXTERNAL_ID%"
  # }
  profile = "default"
}

terraform {
  backend "s3" {
    bucket  = "terraform-devsecops-devco.im.terraform"
    key     = "terraform/infra_iac_curso/terraform.tfstate"
    region  = "us-east-1"
    profile = "default"
  }
}

module "networking" {
  source = "./networking"

  subnet_pub_a_cidr = var.subnet_pub_a_cidr
  vpc_cidr          = var.vpc_cidr
  app               = var.app
}

module "security" {
  source = "./security"

  env                 = terraform.workspace
  subnet_pub_all_cidr = [module.networking.subnet_pub_a_cidr]
  vpc_id              = module.networking.vpc_id
  vpc_cidr            = var.vpc_cidr
  #db_security_group_id = module.security.aws_security_group.db.id
  app = var.app
}


module "bastion" {
  source = "./bastion"

  env = terraform.workspace
  subnet_id   = module.networking.subnet_pub_a_id
  public_key  = var.public_key_bastion
  sg-bastion  = module.security.ec2_security_group_ssh_id

}
