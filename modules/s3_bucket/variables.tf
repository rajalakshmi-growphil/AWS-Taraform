variable "bucket_name" {
  description = "Base name for the S3 bucket"
  type        = string
}

variable "suffix" {
  description = "Optional suffix (without leading hyphen). Example: new"
  type        = string
  default     = "new"
}

variable "add_random_suffix" {
  description = "Append a short random suffix to help ensure global uniqueness"
  type        = bool
  default     = false
}

variable "acl" {
  description = "Canned ACL"
  type        = string
  default     = "private"
}

variable "tags" {
  description = "Tags to apply to the bucket"
  type        = map(string)
  default     = {}
}
