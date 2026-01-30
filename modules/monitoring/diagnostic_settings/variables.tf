variable "name" {
  description = "The name of the diagnostic setting"
  type        = string

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 260
    error_message = "name must be between 1 and 260 characters."
  }
}

variable "target_resource_id" {
  description = "The ID of the resource to apply diagnostics to"
  type        = string

  validation {
    condition     = can(regex("^/subscriptions/", var.target_resource_id))
    error_message = "target_resource_id must be a valid Azure resource ID."
  }
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace"
  type        = string
  default     = ""
}

variable "eventhub_authorization_rule_id" {
  description = "The ID of the Event Hub authorization rule"
  type        = string
  default     = ""
}

variable "storage_account_id" {
  description = "The ID of the storage account"
  type        = string
  default     = ""
}

variable "enabled_logs" {
  description = "List of log categories to enable"
  type        = list(string)
  default     = []

  validation {
    condition     = length(var.enabled_logs) > 0 || length(var.specific_metrics) > 0
    error_message = "At least one log category or metric must be enabled."
  }
}

variable "specific_metrics" {
  description = "List of specific metric categories to enable"
  type        = list(string)
  default     = []
}

variable "metrics_enabled" {
  description = "Whether to enable all metrics"
  type        = bool
  default     = true
}

variable "log_retention_days" {
  description = "The number of days to retain logs in storage account (0 = indefinite)"
  type        = number
  default     = 0

  validation {
    condition     = var.log_retention_days >= 0
    error_message = "log_retention_days must be 0 or greater."
  }
}
