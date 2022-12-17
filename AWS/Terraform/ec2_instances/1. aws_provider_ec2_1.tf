# Terraform Settings Block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Terraform Provider Block
provider "aws" {
  profile = "default"
  region = "us-east-1"
}

# Terraform Resource Block
resource "aws_instance" "ec2" {
  ami           = "ami-005e54dee72cc1d00"   # change accordingly with the region as it differs
  instance_type = "t2.micro"
}