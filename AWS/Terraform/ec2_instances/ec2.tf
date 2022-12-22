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
  region = "us-east-1"
  profile = "default"
}
# Resources Block
resource "aws_instance" "ec2instance" {
  ami = "ami-0b5eea76982371e91"
  instance_type = "t2.micro"
  user_data = file("${path.module}/userdata.sh")
  tags = {
    "Name" = "ec2 demo"
  }
}