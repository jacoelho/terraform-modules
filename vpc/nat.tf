# NAT instance
resource "aws_security_group" "nat" {
  name = "nat"
  description = "Allow services from the private subnet through NAT"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.private_a.cidr_block}"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.private_b.cidr_block}"]
  }

  vpc_id = "${aws_vpc.default.id}"
}

resource "aws_instance" "nat" {
  ami                         = "${var.aws_ubuntu_ami}"
  instance_type               = "t2.micro"
  key_name                    = "${var.aws_key_name}"
  security_groups             = ["${aws_security_group.nat.id}"]
  subnet_id                   = "${aws_subnet.private_b.id}"
  associate_public_ip_address = true
  source_dest_check           = false

  connection {
    user     = "ubuntu"
    key_file = "${var.aws_key_path}"
  }

  tags {
    Name = "nat-server"
  }
}

resource "aws_eip" "nat" {
  instance = "${aws_instance.nat.id}"
  vpc      = true
}
