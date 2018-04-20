data "aws_availability_zones" "vpc_test" {}

# Create a new load balancer in test vpc
resource "aws_elb" "test_elb_api" {
  name               = "test-elb-api"
  # availability_zones = [
  #   "${data.aws_availability_zones.vpc_test.names[0]}", 
  #   "${data.aws_availability_zones.vpc_test.names[1]}",
  # ]

  subnets = [
    "${var.test_public_subnet_id}",
  ]

  security_groups = [
    "${var.test_sg_elb_01}"
  ]

  internal = false

  # access_logs {
  #   bucket        = "foo"
  #   bucket_prefix = "bar"
  #   interval      = 60
  # }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  # listener {
  #   instance_port      = 8000
  #   instance_protocol  = "http"
  #   lb_port            = 443
  #   lb_protocol        = "https"
  #   ssl_certificate_id = "arn:aws:iam::123456789012:server-certificate/certName"
  # }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  instances = [
    "${var.test_api_srv_01}",
    # "${var.test_api_srv_02}",
  ]
  cross_zone_load_balancing   = true
  idle_timeout                = 300
  connection_draining         = true
  connection_draining_timeout = 300

  tags {
    Name = "test_elb_api"
  }
}