provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
}

resource "aws_internet_gateway" "default" {
  vpc_id = "${aws_vpc.default.id}"
}

# Public subnets
resource "aws_subnet" "public_a" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.public_network_1_cidr}"
  availability_zone = "${var.aws_region}${var.region_az_1}"
}

resource "aws_subnet" "public_b" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.public_network_2_cidr}"
  availability_zone = "${var.aws_region}${var.region_az_2}"
}

# Private subnets
resource "aws_subnet" "private_a" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.private_network_1_cidr}"
  availability_zone = "${var.aws_region}${var.region_az_1}"
}

resource "aws_subnet" "private_b" {
  vpc_id            = "${aws_vpc.default.id}"
  cidr_block        = "${var.private_network_2_cidr}"
  availability_zone = "${var.aws_region}${var.region_az_2}"
}

# Routing table for public subnets
resource "aws_route_table" "route_public" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }
}

resource "aws_route_table_association" "route_public_a" {
  subnet_id      = "${aws_subnet.public_a.id}"
  route_table_id = "${aws_route_table.route_public.id}"
}

resource "aws_route_table_association" "route_public_b" {
  subnet_id      = "${aws_subnet.public_b.id}"
  route_table_id = "${aws_route_table.route_public.id}"
}

# Routing table for private subnets
resource "aws_route_table" "route_private" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
}

resource "aws_route_table_association" "route_private_a" {
  subnet_id      = "${aws_subnet.private_a.id}"
  route_table_id = "${aws_route_table.route_private.id}"
}

resource "aws_route_table_association" "route_private_b" {
  subnet_id      = "${aws_subnet.private_b.id}"
  route_table_id = "${aws_route_table.route_private.id}"
}

