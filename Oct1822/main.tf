terraform {
  required_providers {
    aws= {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-2"
}

resource "aws_instance" "joshua-ssh" {
  ami           = var.ami
  instance_type = "t2.micro"
  subnet_id = aws_subnet.tonka_subnet.id
  security_groups = [aws_security_group.joshua_sgroup.id]

  tags = {
    Name = var.instance_name1
  }
}
resource "aws_instance" "joshua-https" {
  ami           = var.ami
  instance_type = "t2.micro"
  subnet_id = aws_subnet.tonka_subnet.id
  security_groups = ["sg-04864f73e3f7363dd"]

  tags = {
    Name = var.instance_name2
  }
}
resource "aws_vpc" "joshua_vpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "Joshua-VPC"
  } 
}
resource "aws_security_group" "joshua_sgroup"{
  name = "Allow-HTTPS"
  vpc_id = aws_vpc.joshua_vpc.id
  ingress {
    description = "SG inbound for Joshua Machine"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "SG outbound for Joshua Machine"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_https"
  }
}
resource "aws_subnet" "tonka_subnet" {
  vpc_id = aws_vpc.joshua_vpc.id
  cidr_block = "192.168.1.0/24"
  tags = {
    Name = "tonka-subnet"
  }
}


