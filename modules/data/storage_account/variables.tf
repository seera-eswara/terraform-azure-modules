variable "name" {
  description = "Storage account name (3-24 lowercase alphanumeric)"
  type        = string
  
  validation {
    condition     = length(var.name) >= 3 && length(var.name) <= 24 && can(regex("^[a-z0-9]+$", var.name))
    error_message = "Storage account name must be 3-24 lowercase alphanumeric characters"
  }
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "account_tier" {
  description = "Storage account tier (Standard or Premium)"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replication type (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS)"
  type        = string
  default     = "GRS"
}

variable "account_kind" {
  description = "Kind of storage account (Storage, StorageV2, BlobStorage, BlockBlobStorage, FileStorage)"
  type        = string
  default     = "StorageV2"
}

variable "access_tier" {
  description = "Access tier (Hot or Cool)"
  type        = string
  default     = "Hot"
}

variable "https_traffic_only_enabled" {
  description = "HTTPS traffic only"
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "Minimum TLS version (TLS1_0, TLS1_1, or TLS1_2)"
  type        = string
  default     = "TLS1_2"
}

variable "shared_access_key_enabled" {
  description = "Enable shared access key"
  type        = bool
  default     = false
}

variable "enable_firewall" {
  description = "Enable firewall rules"
  type        = bool
  default     = true
}

variable "firewall_virtual_network_subnet_ids" {
  description = "Virtual network subnet IDs allowed for firewall"
  type        = list(string)
  default     = []
}

variable "firewall_ip_rules" {
  description = "IP addresses allowed for firewall"
  type        = list(string)
  default     = []
}

variable "create_private_endpoint" {
  description = "Create private endpoint"
  type        = bool
  default     = false
}

variable "private_endpoint_subnet_id" {
  description = "Subnet ID for private endpoint"
  type        = string
  default     = null
}

variable "enable_blob_versioning" {
  description = "Enable blob versioning"
  type        = bool
  default     = true
}

variable "enable_change_feed" {
  description = "Enable change feed"
  type        = bool
  default     = false
}

variable "enable_soft_delete" {
  description = "Enable blob soft delete"
  type        = bool
  default     = true
}

variable "soft_delete_retention_days" {
  description = "Soft delete retention days"
  type        = number
  default     = 30
}

variable "enable_container_soft_delete" {
  description = "Enable container soft delete"
  type        = bool
  default     = true
}

variable "container_soft_delete_retention_days" {
  description = "Container soft delete retention days"
  type        = number
  default     = 30
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
