output "vpc_test_id" {
  value = "${aws_vpc.test.id}"
}

output "test_public_a" {
  value = "${aws_subnet.test_public_a.id}"
}

output "subnet_priv_a_id" {
	value = "${aws_subnet.test_private_a.id}"
}

output "subnet_priv_b_id" {
  value = "${aws_subnet.test_private_b.id}"
}

output "subnet_priv_c_id" {
  value = "${aws_subnet.test_private_c.id}"
}

output "test_sg_webapps" {
  value = "${aws_security_group.test_sg_webapps.id}"
}

output "test_sg_elb_01" {
  value = "${aws_security_group.test_sg_elb_01.id}"
}