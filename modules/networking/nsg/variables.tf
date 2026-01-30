variable "name" {
  description = "The name of the Network Security Group"
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

variable "rules" {
  description = "Security rules for the NSG"
  type = map(object({
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    
    # Optional fields
    source_port_ranges           = optional(list(string))
    destination_port_ranges      = optional(list(string))
    source_address_prefixes      = optional(list(string))
    destination_address_prefixes = optional(list(string))
    source_asg_ids              = optional(list(string))
    destination_asg_ids         = optional(list(string))
  }))
  
  default = {}

  validation {
    condition = alltrue([
      for rule in values(var.rules) :
      contains(["Inbound", "Outbound"], rule.direction)
    ])
    error_message = "direction must be Inbound or Outbound."
  }

  validation {
    condition = alltrue([
      for rule in values(var.rules) :
      contains(["Allow", "Deny"], rule.access)
    ])
    error_message = "access must be Allow or Deny."
  }

  validation {
    condition = alltrue([
      for rule in values(var.rules) :
      contains(["Tcp", "Udp", "*"], rule.protocol)
    ])
    error_message = "protocol must be Tcp, Udp, or *."
  }
}

variable "enable_flow_logs" {
  description = "Enable flow logs for the NSG"
  type        = bool
  default     = false
}

variable "network_watcher_name" {
  description = "The name of the network watcher for flow logs"
  type        = string
  default     = ""
}

variable "network_watcher_resource_group_name" {
  description = "The resource group name of the network watcher"
  type        = string
  default     = ""
}

variable "storage_account_id" {
  description = "The ID of the storage account for flow logs"
  type        = string
  default     = ""
}

variable "flow_logs_version" {
  description = "The version of flow logs (1 or 2)"
  type        = number
  default     = 2

  validation {
    condition     = contains([1, 2], var.flow_logs_version)
    error_message = "flow_logs_version must be 1 or 2."
  }
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace for diagnostics"
  type        = string
  default     = ""
}

variable "enabled_logs" {
  description = "List of log categories to enable"
  type        = list(string)
  default     = ["NetworkSecurityGroupEvent", "NetworkSecurityGroupRuleCounter"]
}

variable "metrics_enabled" {
  description = "Whether to enable metrics"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the NSG"
  type        = map(string)
  default     = {}
}
