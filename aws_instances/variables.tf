variable "amis" {
  type = "map"
  default = {
    eu-west-2 = "ami-f976839e"
    eu-west-3 = "ami-0ebc281c20e89ba4b"
  }
}

variable "region" {
  default="eu-west-2"
}

variable "total_instances" {
  default=1
}

variable "aws_access_key" {}
variable "aws_secret_key" {}