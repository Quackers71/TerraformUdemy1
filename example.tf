# 3j_Exercise

terraform {
  backend "s3" {
    bucket = "terraform-demo-q2018"
    key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

locals {
  regions = {
    staging    = "eu-west-2"
    production = "eu-west-2"
  }

  instance_count = {
    staging    = "1"
    production = "2"
  }
}

module "backend" {
  source           = "./Backend"
  region           = "${local.regions[terraform.workspace]}"
  number_instances = "${local.instance_count[terraform.workspace]}"
}

module "frontend" {
  source           = "./Frontend"
  region           = "${local.regions[terraform.workspace]}"
  number_instances = "${local.instance_count[terraform.workspace]}"
}
