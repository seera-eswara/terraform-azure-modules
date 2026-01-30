variable "name" {
  description = "Name of the Container App"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "container_app_environment_id" {
  description = "Container App Environment ID"
  type        = string
}

variable "revision_mode" {
  description = "Revision mode (Single or Multiple)"
  type        = string
  default     = "Single"
}

variable "enable_identity" {
  description = "Enable system-assigned managed identity"
  type        = bool
  default     = true
}

variable "containers" {
  description = "Container configuration"
  type = map(object({
    name    = string
    image   = string
    cpu     = string
    memory  = string
    port    = optional(number)
    env     = optional(map(string))
    secrets = optional(map(string))
  }))
}

variable "min_replicas" {
  description = "Minimum number of replicas"
  type        = number
  default     = 1
  
  validation {
    condition     = var.min_replicas >= 0 && var.min_replicas <= 25
    error_message = "Min replicas must be between 0 and 25"
  }
}

variable "max_replicas" {
  description = "Maximum number of replicas"
  type        = number
  default     = 10
  
  validation {
    condition     = var.max_replicas >= 1 && var.max_replicas <= 25
    error_message = "Max replicas must be between 1 and 25"
  }
}

variable "enable_ingress" {
  description = "Enable ingress"
  type        = bool
  default     = true
}

variable "external_enabled" {
  description = "External ingress enabled"
  type        = bool
  default     = true
}

variable "target_port" {
  description = "Target port for ingress"
  type        = number
  default     = 80
}

variable "secrets" {
  description = "Secrets map"
  type        = map(string)
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
