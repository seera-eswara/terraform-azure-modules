variable "name" {
  description = "SQL Server name"
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

variable "administrator_login" {
  description = "Administrator login name"
  type        = string
}

variable "administrator_login_password" {
  description = "Administrator login password"
  type        = string
  sensitive   = true
}

variable "server_version" {
  description = "SQL Server version"
  type        = string
  default     = "12.0"
}

variable "minimum_tls_version" {
  description = "Minimum TLS version (1.0, 1.1, 1.2)"
  type        = string
  default     = "1.2"
}

variable "firewall_rules" {
  description = "Firewall rules"
  type = map(object({
    start_ip_address = string
    end_ip_address   = string
  }))
  default = {
    "AllowAzureServices" = {
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }
  }
}

variable "virtual_network_subnet_ids" {
  description = "Virtual network subnet IDs"
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

variable "enable_audit" {
  description = "Enable audit policy"
  type        = bool
  default     = true
}

variable "audit_retention_days" {
  description = "Audit retention days"
  type        = number
  default     = 30
}

variable "storage_account_id" {
  description = "Storage account ID for audit logs"
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

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
