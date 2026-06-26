terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "demo_sg" {
  name        = "cloud-infra-lab-sg"
  description = "Security group for cloud infra lab EC2 instance"

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "cloud-infra-lab-sg"
    Project = "cloud-infra-lab"
  }
}

resource "aws_instance" "demo_ec2" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.demo_sg.id]

  tags = {
    Name    = "cloud-infra-lab-ec2"
    Project = "cloud-infra-lab"
  }
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.demo_ec2.id
}

output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.demo_ec2.public_ip
}

output "instance_state" {
  description = "The state of the EC2 instance"
  value       = aws_instance.demo_ec2.instance_state
}
