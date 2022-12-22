# Input Variables

variable "region_name" {
  description = "Region Name of AWS Resources"
  type = string
  default = "us-east-1"
}
variable "instance_type" {
  description = "Instance type of an EC2 instance"
  type = string
  default = "t2.micro"
}
variable "keypair" {
  description = "Key pair to be used for EC2 instance"
  type = string
  default = "ec2keypair"
}