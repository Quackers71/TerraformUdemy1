variable "aws_access_key" {}
variable "aws_secret_key" {}

terraform {
  resource "aws_s3_bucket" {
    bucket = "terraform-demo-q2018"
    key    = "network/terraform.tfstate"
	region = "us-east-1"
  }
}

provider "aws" {
	
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0ff8a91507f77f867"
  instance_type = "t2.micro"
}