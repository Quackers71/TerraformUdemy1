# VARIABLES
variable "aws_access_key" {}
variable "aws_secret_key" {}

# EU-WEST-2
variable "eu-west-zones" {
  default = ["eu-west-2a", "eu-west-2b"]
}

# EU-CENTRAL-1
variable "eu-central-zones" {
  default = ["eu-central-1a", "eu-central-1b"]
}

# PROVIDERS
# EU-WEST-2
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  alias      = "eu-west-2"
  region     = "eu-west-2"
}

# EU-CENTRAL-1
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  alias      = "eu-central-1"
  region	 = "eu-central-1"
}

# RESOURCES
# EU-WEST-2
resource "aws_instance" "west-frontend" {
  provider              = "aws.eu-west-2"
  ami                   = "ami-f976839e"
  instance_type         = "t2.micro"
  count                 = 2
  availability_zone     = "${var.eu-west-zones[count.index]}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "west-backend" {
  provider              = "aws.eu-west-2"
  ami                   = "ami-f976839e"
  instance_type         = "t2.micro"
  count                 = 2
  availability_zone     = "${var.eu-west-zones[count.index]}"
  lifecycle {
    prevent_destroy = false
  }
}

# EU-CENTRAL-1
resource "aws_instance" "central-frontend" {
  provider              = "aws.eu-central-1"
  ami                   = "ami-0233214e13e500f77"
  instance_type         = "t2.micro"
  count                 = 2
  availability_zone     = "${var.eu-central-zones[count.index]}"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "central-backend" {
  provider              = "aws.eu-central-1"
  ami                   = "ami-0233214e13e500f77"
  instance_type         = "t2.micro"
  count                 = 2
  availability_zone     = "${var.eu-central-zones[count.index]}"
  lifecycle {
    prevent_destroy = false
  }
}

# OUTPUT
output "west-frontend_ip" {
  value = "${aws_instance.west-frontend.*.public_ip}" 
}

output "central-frontend_ip" {
    value = "${aws_instance.central-frontend.*.public_ip}"
}

output "west-backend_ips" {
  value = "${aws_instance.west-backend.*.public_ip}"  
}

output "central-backend_ips" {
  value = "${aws_instance.central-backend.*.public_ip}"
}

