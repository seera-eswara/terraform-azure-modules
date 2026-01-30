variable "name" {
  description = "The name of the private endpoint"
  type        = string

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 80
    error_message = "name must be between 1 and 80 characters."
  }
}

variable "location" {
  description = "Azure region for deployment"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the private endpoint will be deployed"
  type        = string

  validation {
    condition     = can(regex("^/subscriptions/.*", var.subnet_id))
    error_message = "subnet_id must be a valid Azure resource ID."
  }
}

variable "resource_id" {
  description = "The ID of the resource to connect to (e.g., Key Vault, Storage Account, etc.)"
  type        = string

  validation {
    condition     = can(regex("^/subscriptions/.*", var.resource_id))
    error_message = "resource_id must be a valid Azure resource ID."
  }
}

variable "subresources" {
  description = "List of subresources for the private service connection"
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.subresources) > 0
    error_message = "At least one subresource must be specified."
  }
}

variable "is_manual_connection" {
  description = "Whether to require manual approval for the connection"
  type        = bool
  default     = false
}

variable "private_dns_zone_ids" {
  description = "List of private DNS zone IDs for DNS resolution"
  type        = list(string)
  default     = []
}

variable "custom_network_interface_name" {
  description = "Custom name for the network interface"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to the private endpoint"
  type        = map(string)
  default     = {}
}
