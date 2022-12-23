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

# Input Variables - LIST
variable "instance_type_list" {
  description = "List of EC2 Instance Type"
  type = list(string)
  default = [ "t2.micro", "t3.micro", "t3.large" ]
}

# Input Variables - MAP
variable "instance_type_map" {
  description = "Map of EC2 instance types"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "qa" = "t3.small"
    "prod" = "t3.large"
  }
}