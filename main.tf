provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "medingen" {
  source      = "./modules/s3_bucket"
  bucket_name = "medingen"
  acl         = "private"
  tags        = var.common_tags
}

module "medingen_admin_portal" {
  source      = "./modules/s3_bucket"
  bucket_name = "medingen-admin-portal"
  acl         = "private"
  tags        = var.common_tags
}

module "medingen_in" {
  source      = "./modules/s3_bucket"
  bucket_name = "medingen-in"
  acl         = "private"
  tags        = var.common_tags
}

module "medingen_lambda_dev_serverlessdeploymentbucket" {
  source      = "./modules/s3_bucket"
  bucket_name = "medingen-lambda-dev-serverlessdeploymentbucket-vnfuohntfzpc"
  acl         = "private"
  tags        = var.common_tags
}

module "medingen_logs" {
  source      = "./modules/s3_bucket"
  bucket_name = "medingen-logs"
  acl         = "private"
  tags        = var.common_tags
}

module "medingen_portal" {
  source      = "./modules/s3_bucket"
  bucket_name = "medingen-portal"
  acl         = "private"
  tags        = var.common_tags
}

module "medingen_store" {
  source      = "./modules/s3_bucket"
  bucket_name = "medingen-store"
  acl         = "private"
  tags        = var.common_tags
}

module "serverless_framework_deployments_ap_south_1" {
  source      = "./modules/s3_bucket"
  bucket_name = "serverless-framework-deployments-ap-south-1-287273f8-38ec"
  acl         = "private"
  tags        = var.common_tags
}

module "serverless_framework_deployments_us_east_1" {
  source      = "./modules/s3_bucket"
  bucket_name = "serverless-framework-deployments-us-east-1-84f118d-1ac7"
  acl         = "private"
  tags        = var.common_tags
}

module "serverless_framework_state" {
  source      = "./modules/s3_bucket"
  bucket_name = "serverless-framework-state-e5839ba2-bcc9-411e-ad31-e2f35c7e355f"
  # Make the suffix shorter or blank to stay under 63 chars
  suffix      = ""           # or "n"
  acl         = "private"
  tags = {
    Project = "migration"
  }
}

