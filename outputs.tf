output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "db_endpoint" {
  value = module.db.db_endpoint
}

output "s3_buckets" {
  value = module.s3.bucket_names
}

output "route53_zone_id" {
  value = module.route53.zone_id
}

output "route53_name_servers" {
  value = module.route53.name_servers
}