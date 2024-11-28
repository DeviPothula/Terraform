output "ec2_public_i" {
  description = "this is an ip of my ec2 instance"
  value = aws_instance.web01.public_ip
}