provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "web01" {
  ami = var.ami_id
  instance_type = var.instance-type
  user_data = base64encode(file("${path.module}/user-data.sh"))
  tags = {
    Name = var.instance_name
  }
  key_name = "Docker"
}