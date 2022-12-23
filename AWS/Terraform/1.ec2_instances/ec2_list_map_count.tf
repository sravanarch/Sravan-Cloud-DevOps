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
    ami = data.aws_ami.amazon_linux2_ami.id
    instance_type = var.instance_type_list[1]       # LIST
    #instance_type = var.instance_type_map["dev"]
    user_data = file("${path.module}/userdata.sh")
    key_name = var.keypair
    count = 2
    vpc_security_group_ids = [ aws_security_group.allow_ssh.id, aws_security_group.allow_http_https.id ]
    tags = {
        "Name" = "ec2 demo-${count.index}"
  }
}

/*
Example of count.index:
=======================
count = 5
count.index
0, 1, 2, 3, 4

count = 2
count.index
0, 1
*/