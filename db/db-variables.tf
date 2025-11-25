variable "vpc_id" {}
variable "private_subnet_ids" {}
variable "db_allowed_cidrs" {}

variable "db_name" {}
variable "db_username" {}
variable "db_password" {
  sensitive = true
}

variable "db_engine_version" {}
variable "db_instance_class" {}
variable "db_allocated_storage" {}
variable "db_max_allocated_storage" {}

variable "env" {}
