provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "eu-west-2"
}

resource "aws_route53_zone" "primary" {
  name = "quackers.ninja"
}

resource "aws_route53_record" "www" {
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "www.quackers.ninja"
  type    = "A"
  ttl     = "300"
  records = ["198.40.6.7"]
}