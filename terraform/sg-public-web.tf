provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "github-cicd-demo"
    key    = "terrform/state/sg/demo-public-web"
    region = "us-west-2"
  }
}

resource "aws_security_group" "public_web" {
  name        = "public-web-terraform"
  description = "Public Web Access from Terraform"
  vpc_id      = "vpc-bc441ec4"

  ingress {
    description = "Public HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Public HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}