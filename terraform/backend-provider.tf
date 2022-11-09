terraform {
  backend "s3" {
    bucket  = "terraform-elastic-state"
    key     = "state/terraform.tfstate"
    region  = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.21"
    }
  }
}
provider "aws" {
  region  = "us-east-1"
}