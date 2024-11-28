variable "cidr" {
  description = "this cidr block address for my vpc"
  default = "10.0.0.0/16"
  type = string
}
output "publicIpOfInstance" {
  description = "this is output variable which provides public ip df ec2"
  value = aws_instance.ubuntu_server.public_ip
}