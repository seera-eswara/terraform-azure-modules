variable "name" {
  description = "Name of the virtual network"
  type        = string

  validation {
    condition     = length(var.name) >= 2 && length(var.name) <= 64
    error_message = "VNet name must be between 2 and 64 characters."
  }
}

variable "location" {
  description = "Azure region for the virtual network"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network (CIDR blocks)"
  type        = list(string)

  validation {
    condition     = length(var.address_space) > 0
    error_message = "At least one address space must be provided."
  }
}

variable "dns_servers" {
  description = "List of custom DNS servers"
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "Map of subnet configurations"
  type = map(object({
    address_prefixes  = list(string)
    service_endpoints = optional(list(string))
    delegations = optional(list(object({
      name         = string
      service_name = string
      actions      = optional(list(string))
    })))
  }))
  default = {}
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
  description = "Tags to apply to the virtual network"
  type        = map(string)
  default     = {}
}
