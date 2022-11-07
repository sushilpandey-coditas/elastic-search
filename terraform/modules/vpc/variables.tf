variable vpc_cidr_block {
  default = "10.10.0.0/16"
}

variable pub_sub1_cidr_block {
  default = "10.10.1.0/24"
}

variable pub_sub2_cidr_block {
  default = "10.10.2.0/24"
}

variable "environment" {}

variable "region" {}