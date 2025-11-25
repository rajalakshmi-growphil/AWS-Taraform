module "vpc" {
  source = "./vpc"

  vpc_cidr              = var.vpc_cidr
  azs                   = var.azs
  public_subnets_cidrs  = var.public_subnets_cidrs
  private_subnets_cidrs = var.private_subnets_cidrs
  env                   = var.env
}

module "s3" {
  source = "./s3"

  bucket_names = var.bucket_names
  env          = var.env
}

module "db" {
  source = "./db"

  vpc_id                   = module.vpc.vpc_id
  private_subnet_ids       = module.vpc.private_subnet_ids
  db_username              = var.db_username
  db_password              = var.db_password
  db_name                  = var.db_name
  db_engine_version        = var.db_engine_version
  db_instance_class        = var.db_instance_class
  db_allocated_storage     = var.db_allocated_storage
  db_max_allocated_storage = var.db_max_allocated_storage
  db_allowed_cidrs         = [module.vpc.vpc_cidr]
  env                      = var.env
}
