variable "app_code" {
  description = "Three-letter application code (e.g., 'app', 'crm', 'erp')"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3}$", var.app_code))
    error_message = "App code must be exactly 3 lowercase alphanumeric characters."
  }
}

variable "environment" {
  description = "Environment name (dev, stage, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "stage", "prod", "qa", "uat"], var.environment)
    error_message = "Environment must be one of: dev, stage, prod, qa, uat."
  }
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "instance" {
  description = "Instance number for multiple deployments (optional)"
  type        = number
  default     = null

  validation {
    condition     = var.instance == null || (var.instance >= 1 && var.instance <= 99)
    error_message = "Instance must be between 1 and 99 if specified."
  }
}

variable "additional_tags" {
  description = "Additional tags to merge with standard tags"
  type        = map(string)
  default     = {}
}
