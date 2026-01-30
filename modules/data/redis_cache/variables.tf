variable "name" {
  description = "The name of the Redis cache"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]{1,63}$", var.name))
    error_message = "name must be 1-63 characters and contain only lowercase letters, numbers, and hyphens."
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

variable "family" {
  description = "The SKU family of the Redis instance (C or P)"
  type        = string
  default     = "P"

  validation {
    condition     = contains(["C", "P"], var.family)
    error_message = "family must be C (Basic/Standard) or P (Premium)."
  }
}

variable "capacity" {
  description = "The size of the Redis instance"
  type        = number
  default     = 1

  validation {
    condition     = contains([0, 1, 2, 3, 4, 5, 6], var.capacity)
    error_message = "capacity must be between 0 and 6."
  }
}

variable "sku_name" {
  description = "The SKU of the Redis cache (Basic, Standard, or Premium)"
  type        = string
  default     = "Premium"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku_name)
    error_message = "sku_name must be Basic, Standard, or Premium."
  }
}

variable "minimum_tls_version" {
  description = "The minimum TLS version"
  type        = string
  default     = "1.2"

  validation {
    condition     = contains(["1.0", "1.1", "1.2"], var.minimum_tls_version)
    error_message = "minimum_tls_version must be 1.0, 1.1, or 1.2."
  }
}

variable "enable_public_network_access" {
  description = "Enable public network access"
  type        = bool
  default     = false
}

variable "shard_count" {
  description = "The shard count for cluster mode (Premium only)"
  type        = number
  default     = 1

  validation {
    condition     = var.shard_count >= 1 && var.shard_count <= 10
    error_message = "shard_count must be between 1 and 10."
  }
}

variable "zones" {
  description = "Availability zones for Premium tier"
  type        = list(number)
  default     = []
}

variable "replicas_per_master" {
  description = "The number of replica nodes (Premium only)"
  type        = number
  default     = 1

  validation {
    condition     = var.replicas_per_master >= 1 && var.replicas_per_master <= 5
    error_message = "replicas_per_master must be between 1 and 5."
  }
}

variable "redis_configuration" {
  description = "Advanced Redis configuration"
  type = object({
    aof_backup_enabled              = optional(bool, false)
    aof_storage_connection_string_0 = optional(string)
    aof_storage_connection_string_1 = optional(string)
    enable_authentication            = optional(bool, true)
    maxmemory_policy                = optional(string, "allkeys-lru")
    maxmemory_reserved              = optional(number, 2)
    maxmemory_delta                 = optional(number, 2)
    notify_keyspace_events         = optional(string, "")
  })
  default = null
}

variable "firewall_rules" {
  description = "Firewall rules for the Redis cache"
  type = map(object({
    start_ip = string
    end_ip   = string
  }))
  default = {}
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
  default     = ["ConnectedClientList"]
}

variable "metrics_enabled" {
  description = "Whether to enable metrics"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
