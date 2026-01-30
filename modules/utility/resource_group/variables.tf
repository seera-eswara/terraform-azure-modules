variable "name" {
  description = "Name of the resource group"
  type        = string

  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 90
    error_message = "Resource group name must be between 1 and 90 characters."
  }

  validation {
    condition     = can(regex("^[a-zA-Z0-9._()-]+$", var.name))
    error_message = "Resource group name can only contain alphanumerics, periods, underscores, hyphens and parenthesis."
  }
}

variable "location" {
  description = "Azure region for the resource group"
  type        = string

  validation {
    condition = contains([
      "eastus", "eastus2", "westus", "westus2", "westus3", "centralus",
      "northcentralus", "southcentralus", "westcentralus",
      "canadacentral", "canadaeast",
      "northeurope", "westeurope", "uksouth", "ukwest",
      "francecentral", "francesouth", "germanywestcentral",
      "norwayeast", "switzerlandnorth", "swedencentral",
      "southeastasia", "eastasia", "australiaeast", "australiasoutheast",
      "japaneast", "japanwest", "koreacentral", "koreasouth",
      "southindia", "centralindia", "westindia",
      "brazilsouth", "southafricanorth", "uaenorth"
    ], var.location)
    error_message = "Invalid Azure region specified."
  }
}

variable "tags" {
  description = "Tags to apply to the resource group"
  type        = map(string)
  default     = {}
}

variable "create_lock" {
  description = "Whether to create a management lock on the resource group"
  type        = bool
  default     = false
}

variable "lock_level" {
  description = "Level of lock to apply (CanNotDelete or ReadOnly)"
  type        = string
  default     = "CanNotDelete"

  validation {
    condition     = contains(["CanNotDelete", "ReadOnly"], var.lock_level)
    error_message = "Lock level must be either CanNotDelete or ReadOnly."
  }
}
