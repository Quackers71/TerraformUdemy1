### 3d-data-sources.tf

### VARIABLES ###

variable "aws_access_key" {}
variable "aws_secret_key" {}

# EU-WEST-2 = LONDON
variable "eu-west2-zones" {
  default = ["eu-west-2a", "eu-west-2b"]
}

# EU-WEST-3 - PARIS
variable "eu-west3-zones" {
  default = ["eu-west-3c", "eu-west-3b"]
}

variable "multi-region-deployment" {
  default = true
}

variable "environment-name" {
  default = "Terraform-demo"
}


### DATA SOURCES ###

data "aws_availability_zones" "eu-west-2" {
  provider = "aws.eu-west-2"
}

data "aws_availability_zones" "eu-west-3" {
  provider = "aws.eu-west-3"
}


### PROVIDERS ###
# EU-WEST-2
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  alias      = "eu-west-2"
  region     = "eu-west-2"
}

# EU-WEST-3
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  alias      = "eu-west-3"
  region	 = "eu-west-3"
}


### LOCALS ###
locals {
  default_frontend_name = "${join("-",list(var.environment-name, "frontend"))}"
  default_backend_name  = "${join("-",list(var.environment-name, "backend"))}"
}


### RESOURCES ###

# EU-WEST-2 FRONTEND
resource "aws_instance" "west2-frontend" {
  tags = {
    Name = "${local.default_frontend_name}"
  }
	
  depends_on            = ["aws_instance.west2-backend"]
  availability_zone     = "${data.aws_availability_zones.eu-west-2.names[count.index]}"
  provider              = "aws.eu-west-2"
  ami                   = "ami-f976839e"
  instance_type         = "t2.micro"  
}

# EU-WEST-3 FRONTEND
resource "aws_instance" "west3-frontend" {
  tags = {
    Name = "${local.default_frontend_name}"
  }

  count             	= "${var.multi-region-deployment ? 1 : 0}"
  depends_on            = ["aws_instance.west3-backend"]
  availability_zone     = "${data.aws_availability_zones.eu-west-3.names[count.index]}"
  provider              = "aws.eu-west-3"
  ami                   = "ami-0ebc281c20e89ba4b"
  instance_type         = "t2.micro" 
}


# EU-WEST-2 BACKEND
resource "aws_instance" "west2-backend" {
  tags = {
    Name = "${local.default_backend_name}"
  }
	
  count                 = 2
  availability_zone     = "${data.aws_availability_zones.eu-west-2.names[count.index]}"
  provider              = "aws.eu-west-2"
  ami                   = "ami-f976839e"
  instance_type         = "t2.micro"
}

# EU-WEST-3 BACKEND
resource "aws_instance" "west3-backend" {
  tags = {
    Name = "${local.default_backend_name}"
  }

  count                 = "${var.multi-region-deployment ? 2 : 0}"
  availability_zone     = "${data.aws_availability_zones.eu-west-3.names[count.index]}"
  provider              = "aws.eu-west-3"
  ami                   = "ami-0ebc281c20e89ba4b"
  instance_type         = "t2.micro"  
}

### OUTPUT ###
output "west2-frontend_ip" {
  value = "${aws_instance.west2-frontend.*.public_ip}" 
}

output "west3-frontend_ip" {
    value = "${aws_instance.west3-frontend.*.public_ip}"
}

output "west2-backend_ips" {
  value = "${aws_instance.west2-backend.*.public_ip}"  
}

output "west3-backend_ips" {
  value = "${aws_instance.west3-backend.*.public_ip}"
}
