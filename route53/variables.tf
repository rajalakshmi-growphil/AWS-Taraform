variable "zone_name" {
  type        = string
  description = "Hosted zone domain name"
}

variable "records" {
  description = "List of DNS record objects"
  type = list(object({
    name    = string
    type    = string
    ttl     = optional(number)
    records = optional(list(string))
    alias = optional(object({
      name                   = string
      zone_id                = string
      evaluate_target_health = bool
    }))
  }))
}
