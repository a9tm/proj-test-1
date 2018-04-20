# Launch an EC2 instance
resource "aws_instance" "test_api_srv_01" {
  ami = "ami-a0f247d8"
  instance_type = "t2.micro"
  # ebs_optimized = true
  subnet_id = "${var.net_priv_a}"

  vpc_security_group_ids = [
    "${var.test_sg_webapps}",
  ]

  root_block_device {
    volume_type = "gp2"
    volume_size = "8"
    delete_on_termination = true
  }

  tags {
    Name = "test_api_srv_01"
    Role = "API"
  }
}

# resource "aws_instance" "test_api_srv_02" {
#   ami = "ami-a0f247d8"
#   instance_type = "t2.micro"
#   # ebs_optimized = true
#   subnet_id = "${var.net_priv_b}"

#   vpc_security_group_ids = [
#     "${var.test_sg_webapps}",
#   ]

#   root_block_device {
#     volume_type = "gp2"
#     volume_size = "8"
#     delete_on_termination = true
#   }

#   tags {
#     Name = "test_api_srv_02"
#     Role = "API"
#   }
# }