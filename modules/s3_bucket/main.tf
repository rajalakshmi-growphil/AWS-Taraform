resource "aws_s3_bucket" "this" {
  bucket = local.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Use a separate ACL resource (new way)
resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = var.acl
}

locals {
  # Build the final name with suffix / random suffix while keeping under 63 chars
  base          = lower(var.bucket_name)
  suffix_part   = var.suffix != "" ? "-${var.suffix}" : ""
  random_part   = var.add_random_suffix ? "-${random_string.rand[0].result}" : ""
  desired_name  = "${local.base}${local.suffix_part}${local.random_part}"

  # Ensure we don't exceed 63. (If truncated, be mindful of uniqueness)
  bucket_name   = length(local.desired_name) <= 63 ? local.desired_name : substr(local.desired_name, 0, 63)
}

resource "random_string" "rand" {
  count   = var.add_random_suffix ? 1 : 0
  length  = 6
  upper   = false
  special = false
  numeric = true
}

