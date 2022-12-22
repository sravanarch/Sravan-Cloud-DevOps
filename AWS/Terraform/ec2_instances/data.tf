# Source - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami

# Finding an "ami-name" value?
# 1. Launch an Ec2 instance --> Select Amazon linux2 --> copy the ami id (ami-0b5eea76982371e91)
# 2. Go to AMI under Images in EC2 Dashboard, select Public images and 
#       filter with AMI ID = ami-0b5eea76982371e91 in search
# 3. Copy the AMI Name from the result. 
# 4. AMI_NAME is "amzn2-ami-kernel-5.10-hvm-2.0.20221210.1-x86_64-gp2"

# By using this "DATA" blog, we always get the latest AMI-ID using AMI-Name of Amazon linux2 OS

data "aws_ami" "amazon_linux2_ami" {
  most_recent      = true
  owners           = ["amazon"]             # Argument Reference - amazon, aws-marketplace, microsoft

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-gp2"]    # Check above steps to find AMI Name and then replace with * after hvm.                   
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
    name   = "Architecture"
    values = ["x86_64"]
  }
}

