# Terraform Settings Block
terraform {
  required_version = "~> 1.3.6"
  required_providers {
    aws = {                         // local name or arguement with map
      source = "hashicorp/aws"      // It consists of 3 parts (<hostname>/<namespace>/<type>) - hostname is registry.terraform.io
      version = "~> 4.48"           // AWS Provider Version
     }
  }
}

# Provider Block
provider "aws" {                    // name defined under required providers be used here
  region = var.region_name
  profile = "default"
}
# Resources Block
resource "aws_instance" "ec2instance" {
#  ami = "ami-0b5eea76982371e91"
  ami = data.aws_ami.amazon_linux2_ami.id
#  instance_type = "t2.micro"
  instance_type = var.instance_type
  user_data = file("${path.module}/userdata.sh")
  key_name = var.keypair
  vpc_security_group_ids = [ aws_security_group.allow_ssh.id, aws_security_group.allow_http_https.id ]
  tags = {
    "Name" = "ec2 demo"
  }
}
