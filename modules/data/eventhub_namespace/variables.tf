variable "name" {
  description = "The name of the Event Hub namespace"
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
  description = "The SKU of the Event Hub namespace"
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
    condition     = var.capacity >= 1 && var.capacity <= 40
    error_message = "capacity must be between 1 and 40."
  }
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

variable "auto_inflate_enabled" {
  description = "Enable auto-inflate for Premium namespace"
  type        = bool
  default     = true
}

variable "auto_inflate_max_throughput" {
  description = "Maximum throughput units for auto-inflate"
  type        = number
  default     = 20

  validation {
    condition     = var.auto_inflate_max_throughput >= 1 && var.auto_inflate_max_throughput <= 40
    error_message = "auto_inflate_max_throughput must be between 1 and 40."
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
  default     = ["OperationalLogs", "AutoScaleLogs"]
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
