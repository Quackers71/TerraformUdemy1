variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "key_name" {
  default = "QEC2DPC"
}

variable "private_key_path" {}

variable "eu-west-zones" {
  default = ["eu-west-2a", "eu-west-2b"]
}

variable "sg-id" {
  default = "sg-3198445a"
}

variable "number_instances" {
  default = "1"
}

variable "region" {
  default = "eu-west-2"
}