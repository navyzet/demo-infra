terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-3"
}

resource "aws_instance" "demo" {
  ami           = "ami-05e451e12993709b7"
  count = "${var.instance_count}"
  instance_type = "t2.small"
  key_name = "Job key"
  subnet_id = aws_subnet.demo_subnet.id
  vpc_security_group_ids = [aws_security_group.demo_security_group.id]
  tags          = {
    Name        = "Demo server ${count.index + 1}"
    Environment = "Demo"
  }
}

module "key_pair_external" {
  source = "terraform-aws-modules/key-pair/aws"
  key_name   = "Job key"
  public_key = file("${path.module}/id_rsa.pub")
}
