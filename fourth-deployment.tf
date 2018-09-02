# VARIABLES
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "zones" {
  default = ["eu-west-2a", "eu-west-2b"]
}

# PROVIDER
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "eu-west-2"
}


resource "aws_instance" "example" {
  count                 = 2
  availability_zone     = "${var.zones[count.index]}"
  ami                   = "ami-f976839e"
  instance_type         = "t2.micro"
}