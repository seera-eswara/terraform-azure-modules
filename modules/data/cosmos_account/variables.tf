variable "name" {
  description = "The name of the Cosmos DB account"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{3,44}$", var.name))
    error_message = "name must be 3-44 characters and contain only lowercase letters, numbers, and hyphens."
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

variable "kind" {
  description = "Determines the kind of account: GlobalDocumentDB, MongoDB, Parse"
  type        = string
  default     = "GlobalDocumentDB"

  validation {
    condition     = contains(["GlobalDocumentDB", "MongoDB", "Parse"], var.kind)
    error_message = "kind must be GlobalDocumentDB, MongoDB, or Parse."
  }
}

variable "offer_type" {
  description = "Specifies the offer type: Standard or Premium"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.offer_type)
    error_message = "offer_type must be Standard or Premium."
  }
}

variable "consistency_level" {
  description = "Consistency level for the account"
  type        = string
  default     = "Session"

  validation {
    condition     = contains(["Strong", "BoundedStaleness", "Session", "ConsistentPrefix", "Eventual"], var.consistency_level)
    error_message = "consistency_level must be a valid Cosmos DB consistency level."
  }
}

variable "max_interval_in_seconds" {
  description = "Max interval in seconds for bounded staleness"
  type        = number
  default     = 5
}

variable "max_staleness_prefix" {
  description = "Max staleness prefix for bounded staleness"
  type        = number
  default     = 100
}

variable "allowed_ip_addresses" {
  description = "List of allowed IP addresses for firewall"
  type        = list(string)
  default     = []
}

variable "enable_vnet_filter" {
  description = "Enable virtual network filter"
  type        = bool
  default     = false
}

variable "automatic_failover_enabled" {
  description = "Enable automatic failover"
  type        = bool
  default     = true
}

variable "virtual_network_rule_ids" {
  description = "List of virtual network rule IDs"
  type        = list(string)
  default     = []
}

variable "capabilities" {
  description = "List of capabilities for the account"
  type        = list(object({
    name = string
  }))
  default = []
}

variable "backup_type" {
  description = "Backup type: Continuous or Periodic"
  type        = string
  default     = "Continuous"

  validation {
    condition     = contains(["Continuous", "Periodic"], var.backup_type)
    error_message = "backup_type must be Continuous or Periodic."
  }
}

variable "backup_interval_minutes" {
  description = "Backup interval in minutes"
  type        = number
  default     = 240
}

variable "backup_retention_hours" {
  description = "Backup retention in hours"
  type        = number
  default     = 8
}

variable "create_private_endpoint" {
  description = "Whether to create a private endpoint"
  type        = bool
  default     = false
}

variable "private_endpoint_subnet_id" {
  description = "The ID of the subnet for the private endpoint"
  type        = string
  default     = ""
}

variable "private_dns_zone_id" {
  description = "The ID of the private DNS zone"
  type        = string
  default     = ""
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace for diagnostics"
  type        = string
  default     = ""
}

variable "enabled_logs" {
  description = "List of log categories to enable"
  type        = list(string)
  default     = ["DataPlaneRequests", "MongoRequests", "QueryRuntimeStatistics"]
}

variable "metrics_enabled" {
  description = "Whether to enable metrics"
  type        = bool
  default     = true
}

variable "database_name" {
  description = "The name of the database to create"
  type        = string
  default     = "maindb"
}

variable "throughput" {
  description = "The throughput of the database"
  type        = number
  default     = null
}

variable "autoscale_max_throughput" {
  description = "The max autoscale throughput"
  type        = number
  default     = null
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
