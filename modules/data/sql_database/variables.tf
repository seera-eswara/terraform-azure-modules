variable "server_id" {
  description = "The ID of the MSSQL Server"
  type        = string

  validation {
    condition     = can(regex("^/subscriptions/.*", var.server_id))
    error_message = "server_id must be a valid Azure resource ID."
  }
}

variable "database_name" {
  description = "The name of the SQL Database"
  type        = string

  validation {
    condition     = length(var.database_name) > 0 && length(var.database_name) <= 128
    error_message = "database_name must be between 1 and 128 characters."
  }
}

variable "sku_name" {
  description = "The SKU name for the database (e.g., S0, S1, S2, P1, P2, P4)"
  type        = string
  default     = "S0"

  validation {
    condition     = contains(["S0", "S1", "S2", "S3", "P1", "P2", "P4", "P6", "P11", "P15"], var.sku_name)
    error_message = "sku_name must be a valid SQL Database SKU."
  }
}

variable "collation" {
  description = "The collation of the database"
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "backup_retention_days" {
  description = "Backup retention days (7-35)"
  type        = number
  default     = 30

  validation {
    condition     = var.backup_retention_days >= 7 && var.backup_retention_days <= 35
    error_message = "backup_retention_days must be between 7 and 35."
  }
}

variable "threat_detection_emails" {
  description = "Email addresses to receive threat detection alerts"
  type        = list(string)
  default     = []
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace for diagnostics"
  type        = string
  default     = ""
}

variable "enabled_logs" {
  description = "List of log categories to enable"
  type        = list(string)
  default     = ["SQLInsights", "AutomaticTuning", "QueryStoreRuntimeStatistics"]
}

variable "metrics_enabled" {
  description = "Whether to enable metrics"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to the database"
  type        = map(string)
  default     = {}
}
