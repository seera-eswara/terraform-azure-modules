variable "name" {
  description = "Name of the Function App"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "app_service_plan_id" {
  description = "ID of the App Service Plan"
  type        = string
}

variable "storage_account_name" {
  description = "Storage account name for function app"
  type        = string
}

variable "storage_account_access_key" {
  description = "Storage account access key"
  type        = string
  sensitive   = true
}

variable "runtime_name" {
  description = "Runtime name (node, python, java, powershell, custom)"
  type        = string
  default     = "node"

  validation {
    condition     = contains(["node", "python", "java", "powershell", "custom"], var.runtime_name)
    error_message = "Runtime must be one of: node, python, java, powershell, custom"
  }
}

variable "runtime_version" {
  description = "Runtime version"
  type        = string
  default     = "4"
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID for private endpoint"
  type        = string
  default     = null
}

variable "create_private_endpoint" {
  description = "Create a private endpoint"
  type        = bool
  default     = false
}

variable "vnet_integration_subnet_id" {
  description = "Subnet ID for VNet integration"
  type        = string
  default     = null
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  type        = string
  default     = null
}

variable "enable_diagnostics" {
  description = "Enable diagnostic settings"
  type        = bool
  default     = true
}

variable "app_settings" {
  description = "Application settings map"
  type        = map(string)
  default     = {}
}

variable "connection_strings" {
  description = "Connection strings"
  type = map(object({
    type  = string
    value = string
  }))
  default = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
