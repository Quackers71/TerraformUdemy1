# VARIABLES
variable "aws_access_key" {}
variable "aws_secret_key" {}

# PROVIDER
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "eu-west-2"
}

# RESOURCE
resource "aws_instance" "Demo" {
  ami           = "ami-f976839e"
  instance_type = "t2.micro"  
}

