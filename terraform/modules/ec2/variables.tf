variable "ubuntu_ami" {
    default = "ami-0ee23bfc74a881de5"
}

variable "instance_type" {
    default = "t3.medium"
}

variable "pub_sub1_id" {}

variable "sg_id" {}

variable "userdata" { }

variable "environment" {}

variable "region" {}

variable "storage_bucket_name" {
    default = "bucket-for-lambda-test"
}