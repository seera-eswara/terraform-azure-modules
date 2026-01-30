variable "name" {
  description = "The name of the policy assignment"
  type        = string

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 64
    error_message = "name must be between 1 and 64 characters."
  }
}

variable "policy_definition_id" {
  description = "The ID of the policy definition to assign"
  type        = string

  validation {
    condition     = can(regex("^/subscriptions/.*policyDefinitions/.*", var.policy_definition_id)) || can(regex("^/providers/Microsoft.Authorization/policyDefinitions/.*", var.policy_definition_id))
    error_message = "policy_definition_id must be a valid policy definition ID."
  }
}

variable "management_group_id" {
  description = "The ID of the management group to assign the policy to"
  type        = string

  validation {
    condition     = can(regex("^/providers/Microsoft.Management/managementGroups/", var.management_group_id))
    error_message = "management_group_id must be a valid management group ID."
  }
}

variable "enforcement_mode" {
  description = "The enforcement mode for the policy"
  type        = string
  default     = "Default"

  validation {
    condition     = contains(["Default", "DoNotEnforce"], var.enforcement_mode)
    error_message = "enforcement_mode must be Default or DoNotEnforce."
  }
}

variable "display_name" {
  description = "Display name for the policy assignment"
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of the policy assignment"
  type        = string
  default     = ""
}

variable "identity_type" {
  description = "The type of managed identity"
  type        = string
  default     = ""

  validation {
    condition     = contains(["", "SystemAssigned"], var.identity_type)
    error_message = "identity_type must be empty or SystemAssigned."
  }
}

variable "parameters" {
  description = "Parameters for the policy"
  type        = map(any)
  default     = {}
}

variable "create_remediation_task" {
  description = "Whether to create a remediation task for non-compliant resources"
  type        = bool
  default     = false
}

variable "excluded_scopes" {
  description = "List of scopes to exclude from the policy"
  type        = list(string)
  default     = []
}
