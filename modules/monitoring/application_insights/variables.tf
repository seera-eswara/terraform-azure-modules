variable "name" {
  description = "Name of the Application Insights instance"
  type        = string

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 260
    error_message = "Application Insights name must be between 1 and 260 characters."
  }
}

variable "location" {
  description = "Azure region for the Application Insights instance"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "workspace_id" {
  description = "ID of the Log Analytics workspace"
  type        = string
}

variable "application_type" {
  description = "Type of application being monitored (web, ios, java, other, etc.)"
  type        = string
  default     = "web"

  validation {
    condition = contains([
      "web", "ios", "other", "java", "MobileCenter", "Node.JS", "phone", "store"
    ], var.application_type)
    error_message = "Application type must be one of: web, ios, other, java, MobileCenter, Node.JS, phone, store."
  }
}

variable "retention_in_days" {
  description = "Retention period in days (30, 60, 90, 120, 180, 270, 365, 550, 730)"
  type        = number
  default     = 90

  validation {
    condition     = contains([30, 60, 90, 120, 180, 270, 365, 550, 730], var.retention_in_days)
    error_message = "Retention must be one of: 30, 60, 90, 120, 180, 270, 365, 550, 730 days."
  }
}

variable "daily_data_cap_in_gb" {
  description = "Daily data volume cap in GB"
  type        = number
  default     = null
}

variable "sampling_percentage" {
  description = "Percentage of telemetry to sample (0-100)"
  type        = number
  default     = 100

  validation {
    condition     = var.sampling_percentage >= 0 && var.sampling_percentage <= 100
    error_message = "Sampling percentage must be between 0 and 100."
  }
}

variable "disable_ip_masking" {
  description = "Whether to disable IP masking (enables full IP capture)"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the Application Insights instance"
  type        = map(string)
  default     = {}
}
