variable "name" {
  description = "Name of the Container Registry (globally unique, alphanumeric only)"
  type        = string

  validation {
    condition     = length(var.name) >= 5 && length(var.name) <= 50
    error_message = "Registry name must be between 5 and 50 characters."
  }

  validation {
    condition     = can(regex("^[a-zA-Z0-9]+$", var.name))
    error_message = "Registry name can only contain alphanumeric characters."
  }
}

variable "location" {
  description = "Azure region for the Container Registry"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "sku" {
  description = "SKU for the Container Registry (Basic, Standard, Premium)"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "SKU must be Basic, Standard, or Premium."
  }
}

variable "enable_admin_user" {
  description = "Enable admin user for the registry"
  type        = bool
  default     = false
}

variable "network_rule_set" {
  description = "Network rule set configuration (Premium SKU only)"
  type = object({
    default_action = string
    ip_rules       = optional(list(string))
    virtual_network_rules = optional(list(object({
      subnet_id = string
    })))
  })
  default = null
}

variable "georeplications" {
  description = "List of geo-replication locations (Premium SKU only)"
  type = list(object({
    location                = string
    zone_redundancy_enabled = optional(bool, false)
  }))
  default = []
}

variable "retention_policy" {
  description = "Retention policy for untagged manifests"
  type = object({
    enabled = bool
    days    = number
  })
  default = null
}

variable "create_private_endpoint" {
  description = "Whether to create a private endpoint (Premium SKU only)"
  type        = bool
  default     = false
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID for the private endpoint"
  type        = string
  default     = null
}

variable "enable_diagnostics" {
  description = "Enable diagnostic settings"
  type        = bool
  default     = false
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID for diagnostics"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
