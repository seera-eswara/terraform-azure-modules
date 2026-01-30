variable "name" {
  description = "Name of the App Service Plan"
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

variable "os_type" {
  description = "OS type (Linux or Windows)"
  type        = string
  default     = "Linux"
  
  validation {
    condition     = contains(["Linux", "Windows"], var.os_type)
    error_message = "OS type must be either Linux or Windows."
  }
}

variable "kind" {
  description = "The kind of App Service Plan"
  type        = string
  default     = "App"
}

variable "reserved" {
  description = "Is this App Service Plan reserved?"
  type        = bool
  default     = false
}

variable "sku_tier" {
  description = "SKU tier (Free, Shared, Basic, Standard, Premium, PremiumV2, PremiumV3, Isolated, IsolatedV2)"
  type        = string
  default     = "Standard"
}

variable "sku_size" {
  description = "SKU size (B1, S1, P1v2, etc.)"
  type        = string
  default     = "S1"
}

variable "per_site_scaling" {
  description = "Per site scaling enabled"
  type        = bool
  default     = false
}

variable "zone_redundant" {
  description = "Zone redundant deployment"
  type        = bool
  default     = false
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

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
