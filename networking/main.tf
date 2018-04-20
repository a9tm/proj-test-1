# Create an internet gateway for "test" VPC
resource "aws_internet_gateway" "test_internet_gw" {
  vpc_id = "${aws_vpc.test.id}"

  tags {
    Name = "TEST_IGW"
  }
}

# Create a public route table for "test" VPC internet gateway
resource "aws_route_table" "test_public_route_table" {
  vpc_id = "${aws_vpc.test.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.test_internet_gw.id}"
  }

  tags {
    Name = "Test_Route_Table"
  }
}

# Associate route table with above public subnet
resource "aws_route_table_association" "test_route_assoc" {
  subnet_id = "${aws_subnet.test_public_a.id}"
  route_table_id = "${aws_route_table.test_public_route_table.id}"
}

# Request an Elastic IP for NAT
resource "aws_eip" "test_nat_eip" {
  vpc = true
}

# Create NAT gateway with EIP
resource "aws_nat_gateway" "test_nat" {
  allocation_id = "${aws_eip.test_nat_eip.id}"
  subnet_id = "${aws_subnet.test_public_a.id}"
}

# Create route table for NAT
resource "aws_route_table" "test_priv_route_table" {
  vpc_id = "${aws_vpc.test.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.test_nat.id}"
  }

  tags {
    label = "Test_NAT_table"
  }
}

# Associate route table for NAT
resource "aws_route_table_association" "test_priv_a_route_assoc" {
  subnet_id = "${aws_subnet.test_private_a.id}"
  route_table_id = "${aws_route_table.test_priv_route_table.id}"
}

resource "aws_route_table_association" "test_priv_b_route_assoc" {
  subnet_id = "${aws_subnet.test_private_b.id}"
  route_table_id = "${aws_route_table.test_priv_route_table.id}"
}

resource "aws_route_table_association" "test_priv_c_route_assoc" {
  subnet_id = "${aws_subnet.test_private_c.id}"
  route_table_id = "${aws_route_table.test_priv_route_table.id}"
}