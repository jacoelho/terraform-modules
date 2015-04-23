output "vpc_id" {
  value = "${aws_vpc.default.id}"
}

output "public_subnet_1_id" {
  value = "${aws_subnet.public_a.id}"
}

output "public_subnet_2_id" {
  value = "${aws_subnet.public_b.id}"
}

output "private_subnet_1_id" {
  value = "${aws_subnet.private_a.id}"
}

output "private_subnet_2_id" {
  value = "${aws_subnet.private_b.id}"
}
