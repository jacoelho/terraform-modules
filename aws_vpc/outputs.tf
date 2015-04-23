output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

output "public_subnet_1_id" {
  value = "${aws_vpc.public_a.id}"
}

output "public_subnet_2_id" {
  value = "${aws_vpc.public_b.id}"
}

output "private_subnet_1_id" {
  value = "${aws_vpc.private_a.id}"
}

output "private_subnet_2_id" {
  value = "${aws_vpc.private_b.id}"
}
