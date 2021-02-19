provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "github-cicd-demo"
    key    = "/terrform/state/sg/demo-public-web"
    region = "us-west-2"
  }
}

resource "aws_security_group" "public_web" {
  name        = "demo-public-web-tf"
  description = "Public Web Access from Terraform"
  vpc_id      = "vpc-bc441ec4"
}

resource "aws_security_group_rule" "allow_all" {
  type              = "egress"
  protocol          = "-1"
  to_port           = 0
  from_port         = 0
  security_group_id = aws_security_group.public_web
}

resource "aws_security_group_rule" "port_80" {
  type              = "ingress"
  protocol          = "tcp"
  to_port           = 80
  from_port         = 80
  security_group_id = aws_security_group.public_web
}

resource "aws_security_group_rule" "port_443" {
  type              = "ingress"
  protocol          = "tcp"
  to_port           = 443
  from_port         = 443
  security_group_id = aws_security_group.public_web
}
