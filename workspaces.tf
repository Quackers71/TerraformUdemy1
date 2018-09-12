
variable "aws_access_key" {}
variable "aws_secret_key" {}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "eu-west-2"
}

locals {
#  default_name = "${join("-", list(terraform.workspace, "example"))}"
}

resource "aws_instance" "example" {
  tags = {
    Name = "${local.default_name}"
  }

  ami           = "ami-f976839e"
  instance_type = "t2.micro"
}