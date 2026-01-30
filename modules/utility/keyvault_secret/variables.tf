variable "name" {
  description = "Name of the Key Vault secret"
  type        = string

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 127
    error_message = "Secret name must be between 1 and 127 characters."
  }

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]+$", var.name))
    error_message = "Secret name can only contain alphanumeric characters and hyphens."
  }
}

variable "value" {
  description = "Value of the Key Vault secret"
  type        = string
  sensitive   = true
}

variable "key_vault_id" {
  description = "ID of the Key Vault"
  type        = string
}

variable "content_type" {
  description = "Content type of the secret (e.g., password, certificate, api-key)"
  type        = string
  default     = null
}

variable "expiration_date" {
  description = "Expiration date of the secret in RFC3339 format (e.g., 2026-12-31T23:59:59Z)"
  type        = string
  default     = null

  validation {
    condition = var.expiration_date == null || can(
      formatdate("RFC3339", var.expiration_date)
    )
    error_message = "Expiration date must be in RFC3339 format (e.g., 2026-12-31T23:59:59Z)."
  }
}

variable "not_before_date" {
  description = "Not-before date of the secret in RFC3339 format"
  type        = string
  default     = null

  validation {
    condition = var.not_before_date == null || can(
      formatdate("RFC3339", var.not_before_date)
    )
    error_message = "Not-before date must be in RFC3339 format (e.g., 2026-01-01T00:00:00Z)."
  }
}

variable "tags" {
  description = "Tags to assign to the secret"
  type        = map(string)
  default     = {}
}
