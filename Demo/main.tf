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

resource "aws_instance" "joshua" {
  ami           = "ami-0f924dc71d44d23e2"
  instance_type = "t2.micro"
  security_groups = ["Demo_SG"]

  tags = {
    Name = "DemoApp"
  }
}

