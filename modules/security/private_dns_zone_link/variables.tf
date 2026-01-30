variable "name" {
  description = "The name of the private DNS zone link"
  type        = string

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 80
    error_message = "name must be between 1 and 80 characters."
  }
}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone"
  type        = string

  validation {
    condition     = can(regex("^/subscriptions/.*/privateDnsZones/", var.private_dns_zone_id))
    error_message = "private_dns_zone_id must be a valid private DNS zone ID."
  }
}

variable "virtual_network_id" {
  description = "The ID of the virtual network to link"
  type        = string

  validation {
    condition     = can(regex("^/subscriptions/.*/virtualNetworks/", var.virtual_network_id))
    error_message = "virtual_network_id must be a valid virtual network ID."
  }
}

variable "registration_enabled" {
  description = "Whether to enable auto-registration of virtual machine records in the DNS zone"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the link"
  type        = map(string)
  default     = {}
}
