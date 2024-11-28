provider "aws" {
  region = "ap-south-1"
}

module "my-ubuntu-instance" {
  #In source mention the path where your module to create ec2 instance exist
  source        = "./modules/ec2-instance"
  #these are values which you resource taking dynamically
  ami_id        = "ami-0dee22c13ea7a9a67"
  instance-type = "t2.micro"
  instance_name = "Ubuntu-Ec2-Instance"
}

module "my-linux-instance" {
  source        = "./modules/ec2-instance"
  ami_id        = "ami-0614680123427b75e"
  instance-type = "t2.micro"
  instance_name = "Linux-Ec2-Instance"
}
