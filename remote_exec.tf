provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "eu-west-2"
}

resource "aws_instance" "frontend" {
  availability_zone      = "${var.eu-west-zones[count.index]}"
  ami                    = "ami-c7ab5fa0"
  instance_type          = "t2.micro"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.sg-id}"]

  lifecycle {
    create_before_destroy = true
  }

  connection {
    user        = "ubuntu"
    type        = "ssh"
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    source      = "./frontend"
    destination = "~/"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/frontend/run_frontend.sh",
      "cd ~/frontend",
      "sed -i -e 's/\r$//' run_frontend.sh",
      "sudo ~/frontend/run_frontend.sh",
    ]
  }
}