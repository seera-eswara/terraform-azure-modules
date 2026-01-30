variable "name" {
  description = "The name of the Log Analytics workspace"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{4,63}$", var.name))
    error_message = "name must be 4-63 characters and contain only letters, numbers, and hyphens."
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
  description = "The SKU of the Log Analytics workspace"
  type        = string
  default     = "PerGB2018"

  validation {
    condition     = contains(["Free", "Standard", "Premium", "PerGB2018", "Standalone"], var.sku)
    error_message = "sku must be a valid Log Analytics SKU."
  }
}

variable "retention_days" {
  description = "Data retention in days (7-730)"
  type        = number
  default     = 30

  validation {
    condition     = var.retention_days >= 7 && var.retention_days <= 730
    error_message = "retention_days must be between 7 and 730."
  }
}

variable "daily_quota_gb" {
  description = "Daily quota in GB (0 = unlimited)"
  type        = number
  default     = 0

  validation {
    condition     = var.daily_quota_gb >= 0
    error_message = "daily_quota_gb must be 0 or greater."
  }
}

variable "internet_ingestion_enabled" {
  description = "Enable internet ingestion"
  type        = bool
  default     = true
}

variable "internet_query_enabled" {
  description = "Enable internet query"
  type        = bool
  default     = true
}

variable "cmk_enabled" {
  description = "Enable customer-managed key encryption"
  type        = bool
  default     = false
}

variable "solutions" {
  description = "List of solutions to add to the workspace"
  type        = list(string)
  default     = []
}

variable "saved_searches" {
  description = "Saved searches for the workspace"
  type = map(object({
    query        = string
    display_name = string
    category     = optional(string, "General")
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to the workspace"
  type        = map(string)
  default     = {}
}
