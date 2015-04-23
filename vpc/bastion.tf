# Bastion
resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Allow SSH traffic from the internet"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.default.id}"
}

resource "aws_instance" "bastion" {
  ami               = "${var.aws_ubuntu_ami}"
  instance_type     = "t2.micro"
  key_name          = "${var.aws_key_name}"
  security_groups   = ["${aws_security_group.bastion.id}"]
  subnet_id         = "${aws_subnet.public_b.id}"

  connection {
    user     = "ubuntu"
    key_file = "${var.aws_key_path}"
  }

  tags {
    Name        = "bastion-server"
    Environment = "${var.environment_name}"
  }
}

resource "aws_eip" "bastion" {
  instance = "${aws_instance.bastion.id}"
  vpc      = true
}

