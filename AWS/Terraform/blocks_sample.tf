/*
TERRAFORM BASIC BLOCKS:
  1. Terraform Block (Available from 0.13 version)
  2. Provider Block
  3. Resource Block

  1. TERRAFORM BLOCK: 
      - It is used to define some special behavious such as:
        * Required Terraform Version
        * List required providers
        * Terraform Backend

        NOTE:
        * Terraform Block can be called in 3 ways, all means the same.
            - Terraform block
            - Terraform settings block
            - Terraform configuration block
        * Each terraform block can contain a number of settings related to "Terraform's behaviour"
        
        IMPORTANT NOTE:
        * Within a terraform block, ONLY CONSTANT VALUES can be used
        * ARGUMENTS may not refer to named objects such as RESOURCES, INPUT VARIABLES, ETC
                    may not use any of the Terraform language built-in functions.
        * Before 0.13 version, TERRAFORM block is defined in PROVIDER block

  2. PROVIDER BLOCK:
      - It is a heart of Terraform
      - This block is between the AWS CLI & endpoint (AWS or Azure Cloud Provider)
      - Terraform relies on PROVIDERS to interact with remote systems
      - Declare PROVIDERS for Terraform to install providers & use them.
      - PROVIDER configurations belong to ROOT Module

  3. RESOURCE BLOCK:
      - Each resource block describes one or more infrastructure objects
      - Resource syntax to declare resources
      - Resource behaviour to handle resource declarations
      - We can configure resource post-creation actions
*/

/*
DIFFERENCE BETWEEN 0.12 VS 0.13 ONWARDS

0.12 OR BEFORE:
===============
provider "aws" {
  version = "~>3.0"
  region = "us-east-1"
}
resource "aws_vpc" "vpcsetup" {
  cidr_block = "10.0.0.0/8"
}

0.13 ONWARDS:
=============
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  } 
}
provider "aws" {
  region = "us-east-1"
}
resource "aws-vpc" "vpcsetup" {
  cidr_block = "10.0.0.0/8"
}
*/

# 1. Terraform Settings Block
terraform {
  required_version = "~> 0.14.3"    // Terraform version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
    backend "s3" {                      // For storing terraform state file in an S3 Bucket
    bucket = "sravanbucket"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-lock-dynamo"      // For locking terraform state file in Dynamo DB
  }
}

# 2. Provider Block
provider "aws" {
  profile = "default" # AWS Credentials Profile configured on your local desktop terminal  $HOME/.aws/credentials
  region  = "us-east-1"
}


# 3. Resource Block             
resource "aws_instance" "ec2instance" {     // aws_instance - resource_type, ec2instance - resource_name             
  ami           = "ami-xxxxxx" # Amazon Linux
  instance_type = var.inst_type
}


# 4. Input Variables Block
variable "inst_type" {
  default = "t2.medium"
  description = "EC2 Instance Type"
  type = string
}

variable "app_name" {
  default = "sravan-mobile"
  type = string
}

# 5. Output Values Block
output "ec2_instance_publicip" {
  description = "EC2 Instance Public IP"
  value = aws_instance.ec2instance.public_ip
}

# 6. Local Values Block
locals {
  bucket-name-prefix = "${var.app_name}-${var.environment_name}"
}

# 7. Data Sources Block
# Get latest AMI ID for Amazon Linux2 OS

data "aws_ami" "amazonlinux" {
  most_recent      = true
  owners           = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# 8. Modules Block
module "ec2_block" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"
  name                   = "sravan-modules"
  instance_count         = 1
  ami                    = data.aws_ami.amzlinux.id     // Data block is used here for getting latest AMI ID
  instance_type          = "t2.medium"
  key_name               = "terraform-key"
  monitoring             = false                        // true or false
  vpc_security_group_ids = ["sg-xxxxxxx"]  # Get Default VPC Security Group ID and replace
  subnet_id              = "subnet-xxxxx" # Get one public subnet id from default vpc and replace
  user_data               = file("apache-install.sh")
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}