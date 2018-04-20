data "aws_availability_zones" "test" {}

# Create a VPC with "VPC_TEST" name
resource "aws_vpc" "test" {
  cidr_block = "${var.vpc_test_cidr}"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags {
    label = "VPC_TEST"
  }
}

# Create a public subnet
resource "aws_subnet" "test_public_a" {
  vpc_id = "${aws_vpc.test.id}"
  cidr_block = "${var.test_public_cidr}"
  availability_zone = "${data.aws_availability_zones.test.names[0]}"
  map_public_ip_on_launch = false
  tags {
    Name = "Public_A"
  }
}

# Create a private subnet
resource "aws_subnet" "test_private_a" {
  vpc_id = "${aws_vpc.test.id}"
  cidr_block = "${var.test_priv_a_cidr}"
  availability_zone = "${data.aws_availability_zones.test.names[0]}"
  tags {
    Name = "Private_A"
  }
}

resource "aws_subnet" "test_private_b" {
  vpc_id = "${aws_vpc.test.id}"
  cidr_block = "${var.test_priv_b_cidr}"
  availability_zone = "${data.aws_availability_zones.test.names[1]}"
  tags {
    Name = "Private_B"
  }
}

resource "aws_subnet" "test_private_c" {
  vpc_id = "${aws_vpc.test.id}"
  cidr_block = "${var.test_priv_c_cidr}"
  availability_zone = "${data.aws_availability_zones.test.names[0]}"
  tags {
    Name = "Private_C"
  }
}