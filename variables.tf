variable "region" {
  default = "ap-south-1"
}

variable "profile" {
  default = "kyra"
}

variable "env" {
  default = "dev"
}

variable "vpc_cidr" {
  default = "10.10.0.0/16"
}

variable "azs" {
  default = ["ap-south-1a", "ap-south-1b"]
}

variable "public_subnets_cidrs" {
  default = ["10.10.1.0/24", "10.10.2.0/24"]
}

variable "private_subnets_cidrs" {
  default = ["10.10.11.0/24", "10.10.12.0/24"]
}

variable "bucket_names" {
  type = list(string)
  default = [
    "medingen-new",
    "medingen-admin-portal-new",
    "medingen-in-new",
    "medingen-logs-new",
    "medingen-portal-new",
    "medingen-store-new"
  ]
}

# RDS Vars
variable "db_name" {
  default = "medingen"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  sensitive = true
}

variable "db_engine_version" {
  default = "8.0"
}

variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "db_allocated_storage" {
  default = 20
}

variable "db_max_allocated_storage" {
  default = 100
}
