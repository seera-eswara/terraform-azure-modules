variable "app_code" {
  description = "Application code (e.g., RFF, APP, CRM)"
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9]{3,10}$", var.app_code))
    error_message = "app_code must be 3-10 alphanumeric characters."
  }
}

variable "parent_management_group_id" {
  description = "ID of the parent management group (Applications MG from landing zone)"
  type        = string
}

variable "app_owners" {
  description = "Principal IDs to assign as app management group owners"
  type        = list(string)
  default     = []
}

variable "app_contributors" {
  description = "Principal IDs to assign as app management group contributors"
  type        = list(string)
  default     = []
}
