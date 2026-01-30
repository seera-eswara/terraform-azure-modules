variable "name" {
  description = "Name of the storage container"
  type        = string

  validation {
    condition     = length(var.name) >= 3 && length(var.name) <= 63
    error_message = "Container name must be between 3 and 63 characters."
  }

  validation {
    condition     = can(regex("^[a-z0-9]([a-z0-9-]*[a-z0-9])?$", var.name))
    error_message = "Container name must start and end with lowercase letter or number, and can only contain lowercase letters, numbers, and hyphens."
  }
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "container_access_type" {
  description = "Access level for the container (private, blob, or container)"
  type        = string
  default     = "private"

  validation {
    condition     = contains(["private", "blob", "container"], var.container_access_type)
    error_message = "Container access type must be private, blob, or container."
  }
}

variable "metadata" {
  description = "Metadata key-value pairs for the container"
  type        = map(string)
  default     = {}
}
