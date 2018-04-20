
# Get AMI ID of latest version of Debian Stretch (9.3)
data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-stretch-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["379101102735"] # Debian
}

# Create a launch configuration for the auto-scaling
resource "aws_launch_configuration" "test_as_conf" {
  name_prefix   = "test-as-conf-"
  image_id      = "${data.aws_ami.debian.id}"
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}

# Create auto-scaling group with previously created launch config
resource "aws_autoscaling_group" "test_asg" {
  name_prefix = "test-asg-example-"
  launch_configuration = "${aws_launch_configuration.test_as_conf.name}"
  health_check_type = "EC2"
  min_size  = 1
  max_size  = 1

  vpc_zone_identifier = [
    "${var.net_priv_a}", 
    "${var.net_priv_b}", 
  ]

  load_balancers = [
    "${var.test_elb_api}"
  ]

  lifecycle {
    create_before_destroy = true
  }
}