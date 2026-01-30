variable "name" {
  description = "The name of the Service Bus namespace"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{1,50}$", var.name))
    error_message = "name must be 1-50 characters and contain only letters, numbers, and hyphens."
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

variable "sku" {
  description = "The SKU of the Service Bus namespace"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "sku must be Basic, Standard, or Premium."
  }
}

variable "capacity" {
  description = "The capacity of the namespace (for Premium SKU)"
  type        = number
  default     = 1

  validation {
    condition     = var.capacity >= 1 && var.capacity <= 10
    error_message = "capacity must be between 1 and 10."
  }
}

variable "enable_local_auth" {
  description = "Enable local authentication (not recommended for security)"
  type        = bool
  default     = false
}

variable "enable_public_network_access" {
  description = "Enable public network access"
  type        = bool
  default     = false
}

variable "virtual_network_rule_ids" {
  description = "List of virtual network rule subnet IDs"
  type        = list(string)
  default     = []
}

variable "allowed_ip_addresses" {
  description = "List of allowed IP addresses in CIDR format"
  type        = list(string)
  default     = []
}

variable "premium_messaging_partitions" {
  description = "Number of premium messaging partitions (Premium only)"
  type        = number
  default     = 1

  validation {
    condition     = var.premium_messaging_partitions >= 1 && var.premium_messaging_partitions <= 4
    error_message = "premium_messaging_partitions must be between 1 and 4."
  }
}

variable "create_private_endpoint" {
  description = "Whether to create a private endpoint"
  type        = bool
  default     = false
}

variable "private_endpoint_subnet_id" {
  description = "The ID of the subnet for the private endpoint"
  type        = string
  default     = ""
}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone"
  type        = string
  default     = ""
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace for diagnostics"
  type        = string
  default     = ""
}

variable "enabled_logs" {
  description = "List of log categories to enable"
  type        = list(string)
  default     = ["OperationalLogs"]
}

variable "metrics_enabled" {
  description = "Whether to enable metrics"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
