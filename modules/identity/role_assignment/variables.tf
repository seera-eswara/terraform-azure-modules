variable "principal_id" {
  description = "The ID of the principal (user, service principal, group, or managed identity)"
  type        = string

  validation {
    condition     = length(var.principal_id) > 0
    error_message = "principal_id cannot be empty."
  }
}

variable "role_definition_name" {
  description = "The name of the role to assign (e.g., 'Reader', 'Contributor')"
  type        = string
  default     = ""
}

variable "role_definition_id" {
  description = "The ID of the role to assign"
  type        = string
  default     = ""

  validation {
    condition     = var.role_definition_id == "" || can(regex("^/subscriptions/.*/providers/Microsoft.Authorization/roleDefinitions/", var.role_definition_id))
    error_message = "role_definition_id must be a valid Azure role ID."
  }
}

variable "scope" {
  description = "The scope for the role assignment (subscription, resource group, or resource ID)"
  type        = string

  validation {
    condition     = can(regex("^/subscriptions/", var.scope))
    error_message = "scope must be a valid Azure resource ID starting with /subscriptions/."
  }
}

variable "skip_service_principal_aad_check" {
  description = "Skip service principal AAD check"
  type        = bool
  default     = false
}
