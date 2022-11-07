module "vpc" {
  source = "./modules/vpc"

  environment = var.environment
  region      = var.region
}