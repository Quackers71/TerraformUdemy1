variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "key_name" {
  default = "QBorBoxKey"
}

variable "private_key_path" {}

variable "eu-west-zones" {
  default = ["eu-west-2a", "eu-west-2b"]
}

variable "sg-id" {
  default = "sg-3198445a"
}