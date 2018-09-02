# VARIABLES
variable "aws_access_key" {}
variable "aws_secret_key" {}

# PROVIDER
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "eu-west-2"
}
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  alias      = "eu-central-1"
  region	 = "eu-central-1"
}

# RESOURCE
resource "aws_instance" "eu_central_example" {
  provider      = "aws.eu-central-1"  
  ami           = "ami-0233214e13e500f77"
  instance_type = "t2.micro"
}

resource "aws_instance" "eu_west_example" {
  ami           = "ami-f976839e"
  instance_type = "t2.micro"
}
