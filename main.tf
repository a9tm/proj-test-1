# Put my terraform state file to S3 bucket
terraform {
  backend "s3" {
    bucket = "e5p3zgd9mzqxwzkj"
    region = "us-west-2"
    key = "test/terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = "${var.my_tfstate_region}"
  shared_credentials_file = "~/.aws/credentials"
  profile = "namm1822"
}

# Retrieve my terraform state file from S3 bucket
data "terraform_remote_state" "test" {
  backend = "s3"
  config {
    bucket = "${var.my_tfstate_bucket}"
    key = "terraform.tfstate"
    region = "${var.my_tfstate_region}"
    encrypt = true
  }
}

module "networking" {
  source = "./networking"
}

module "webapps" {
  source = "./ec2"
  this_vpc_id = "${module.networking.vpc_test_id}"
  net_priv_a = "${module.networking.subnet_priv_a_id}"
  net_priv_b = "${module.networking.subnet_priv_b_id}"
  test_sg_webapps = "${module.networking.test_sg_webapps}"
  test_elb_api = "${module.elb.test_elb_api}"
}

module "elb" {
  source = "./elb"
  this_vpc_id = "${module.networking.vpc_test_id}"
  test_public_subnet_id = "${module.networking.test_public_a}"
  test_sg_elb_01 = "${module.networking.test_sg_elb_01}"
  test_api_srv_01 = "${module.webapps.test_api_srv_01}"
  # test_api_srv_02 = "${module.webapps.test_api_srv_02}"
}