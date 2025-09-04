variable "aws_profile" {
  description = "AWS named profile to use"
  type        = string
  default     = "new-account"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    Project = "migration"
    ManagedBy = "terraform"
  }
}
