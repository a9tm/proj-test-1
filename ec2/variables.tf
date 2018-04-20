variable "this_vpc_id" {}
variable "net_priv_a" {}
variable "net_priv_b" {}
variable "test_sg_webapps" {}
variable "test_elb_api" {}

variable "srv_01" { default = "test_srv_01" }
variable "srv_02" { default = "test_srv_02" }

variable "my_ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAof6DFbbcMLOnB5Zl59VDwVmR8WaCTvEgdAtse8NdJqXmsKk99HOHit9mvy/YomkU/y66f7j6WySkqKK6l3eLXQE71GNV5vd8hWMLlQGiAw9w3GuFa5kxYJpFlyTj7zTe+6Yz09uF74MdW9yA9fK84gZoz27oyJy8/ptAlD30Qq5inA7SeT1Eg3+2h2auSWWgoajlCbDukEorg9aNFh7Pm2DCtwQvGb46rtPA0i0pHGyV4oLnYlRrveUNihVhSLdQjSlKq3UDCC0sEds3CpZtoywWDWbZLMv28A9aSLodnA0VwedLVaBrNsnvCQ8WM/DT4gw41AnJH9/0H2NfxLfClw== nam.nguyen"
}