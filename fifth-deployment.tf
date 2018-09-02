# VARIABLES
variable "aws_access_key" {}
variable "aws_secret_key" {}

# PROVIDER
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "eu-west-2"
}

# RESOURCES
resource "aws_instance" "frontend" {
  ami                   = "ami-f976839e"
  instance_type         = "t2.micro"
}

resource "aws_instance" "backend" {
  count                 = 2
  ami                   = "ami-f976839e"
  instance_type         = "t2.micro"
}

# OUTPUT
output "frontend_ip" {
  description = "List of public IP addresses assigned to the instances"
  value = "${aws_instance.frontend.public_ip}"
}

output "backend_ips" {
  description = "List of public IP addresses assigned to the instances"
  value = "${aws_instance.backend.*.public_ip}"
}