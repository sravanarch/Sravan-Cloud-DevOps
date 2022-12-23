output "instance_public_ip" {
  description = "Public IP of EC2 Instance"
  value = aws_instance.ec2instance.public_ip
}
output "instance_public_dns" {
  description = "DNS of EC2 Instance"
  value = aws_instance.ec2instance.public_dns
}

# FOR LOOP with LIST
output "for_output_list" {
  description = "for loop with list"
  value = 
}
