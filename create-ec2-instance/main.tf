#creating vpc 
resource "aws_vpc" "my-vpc" {
  cidr_block = var.cidr
}

#creating subnet1
resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  #this is to allow assign ip to subnet to access our web server on browser
  map_public_ip_on_launch = true
}

#creating subnet-2
resource "aws_subnet" "subnet-2" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
}

#creating internet-gateway to allow traffic from internet 
#because we are creating our instance in virtual private network
#we can't directly access resources in it
#ing will allowed that
resource "aws_internet_gateway" "ing" {
  vpc_id = aws_vpc.my-vpc.id
}

#creating route table
resource "aws_route_table" "routeTable" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ing.id
  }
}

#now its time to associate our route table to subnet
resource "aws_route_table_association" "rta1" {
  route_table_id = aws_route_table.routeTable.id
  subnet_id      = aws_subnet.subnet-1.id
}

resource "aws_route_table_association" "rta2" {
  route_table_id = aws_route_table.routeTable.id
  subnet_id      = aws_subnet.subnet-2.id
}

#creating security grp for my ec2
resource "aws_security_group" "instance_sg" {
  vpc_id = aws_vpc.my-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
}

#creating instance
resource "aws_instance" "ubuntu_server" {
  ami             = "ami-0dee22c13ea7a9a67" # Ubuntu Server 22.04 LTS for us-east-1
  instance_type   = "t2.micro"              # Free-tier eligible instance type
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  subnet_id       = aws_subnet.subnet-1.id

  tags = {
    Name = "Ubuntu EC2 Instance"
  }

  # Key pair (Optional, if you want SSH access)
  key_name = "Docker" # Replace with an existing key pair name in AWS
}

#creating s3 bucket
