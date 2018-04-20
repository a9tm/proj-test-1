
resource "aws_security_group" "test_sg_webapps" {
  name = "test_sg_webapps"
  description = "allow traffic to webapps"
  vpc_id = "${aws_vpc.test.id}"

  ingress {
    from_port = "0"
    to_port = "65535"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "test_sg_webapps"
  }
}

resource "aws_security_group" "test_sg_elb_01" {
  name = "test_sg_elb_01"
  description = "allow traffic to elb"
  vpc_id = "${aws_vpc.test.id}"

  ingress {
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "test_sg_elb_01"
  }
}