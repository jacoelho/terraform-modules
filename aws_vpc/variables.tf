variable "aws_access_key" { }
variable "aws_secret_key" { }
variable "aws_key_path"   { }
variable "aws_key_name"   { }
variable "aws_region"     { }
variable "aws_ubuntu_ami" { }

variable "environment_name" {
  default = "testing"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "region_az_1" {
  default = "a"
}
variable "region_az_2" {
  default = "b"
}

variable "public_network_1_cidr" {
  default = "10.0.0.0/24"
}

variable "public_network_2_cidr" {
  default = "10.0.1.0/24"
}

variable "private_network_1_cidr" {
  default = "10.0.100.0/24"
}
variable "private_network_2_cidr" {
  default = "10.0.101.0/24"
}
