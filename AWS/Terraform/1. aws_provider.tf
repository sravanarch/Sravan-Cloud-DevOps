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
  # Configuration options
}

# Terraform Resource Block
