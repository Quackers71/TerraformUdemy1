### VARIABLES ###

variable "aws_access_key" {}
variable "aws_secret_key" {}

# EU-WEST-2
variable "eu-west-zones" {
  default = ["eu-west-2a", "eu-west-2b"]
}

# EU-CENTRAL-1
variable "eu-central-zones" {
  default = ["eu-central-1c", "eu-central-1b"]
}

variable "multi-region-deployment" {
  default = true
}

variable "environment-name" {
  default = "Terraform-demo"
}


### PROVIDERS ###
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


### RESOURCES ###

# EU-WEST-2 FRONTEND
resource "aws_instance" "west-frontend" {
  tags = {
    Name = "${join("-",list(var.environment-name, "west-frontend"))}"
  }
	
  depends_on            = ["aws_instance.west-backend"]
  availability_zone     = "${var.eu-west-zones[count.index]}"
  provider              = "aws.eu-west-2"
  ami                   = "ami-f976839e"
  instance_type         = "t2.micro"  
}

# EU-CENTRAL-1 FRONTEND
resource "aws_instance" "central-frontend" {
  tags = {
    Name = "${join("-",list(var.environment-name, "central-frontend"))}"
  }
	
  count                 = "${var.multi-region-deployment ? 1 : 0}"
  depends_on            = ["aws_instance.central-backend"]
  availability_zone     = "${var.eu-central-zones[count.index]}"
  provider              = "aws.eu-central-1"
  ami                   = "ami-0233214e13e500f77"
  instance_type         = "t2.micro" 
}


# EU-WEST-2 BACKEND
resource "aws_instance" "west-backend" {
  tags = {
    Name = "${join("-", list(var.environment-name, "west-backend"))}"
  }
	
  count                 = 2
  availability_zone     = "${var.eu-west-zones[count.index]}"
  provider              = "aws.eu-west-2"
  ami                   = "ami-f976839e"
  instance_type         = "t2.micro"
}

# EU-CENTRAL-1 BACKEND
resource "aws_instance" "central-backend" {
  tags = {
    Name = "${join("-", list(var.environment-name, "central-backend"))}"
  }

  count                 = "${var.multi-region-deployment ? 2 : 0}"
  availability_zone     = "${var.eu-central-zones[count.index]}"
  provider              = "aws.eu-central-1"
  ami                   = "ami-0233214e13e500f77"
  instance_type         = "t2.micro"  
}

### OUTPUT ###
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
