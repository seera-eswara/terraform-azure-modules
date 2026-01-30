variable "environment" {
  description = "Environment name (e.g., production, staging, dev)"
  type        = string

  validation {
    condition     = contains(["production", "prod", "staging", "stage", "development", "dev", "qa", "test", "sandbox"], lower(var.environment))
    error_message = "Environment must be one of: production, prod, staging, stage, development, dev, qa, test, sandbox."
  }
}

variable "application" {
  description = "Application or service name"
  type        = string

  validation {
    condition     = length(var.application) >= 2 && length(var.application) <= 50
    error_message = "Application name must be between 2 and 50 characters."
  }
}

variable "cost_center" {
  description = "Cost center code for billing and charge-back"
  type        = string

  validation {
    condition     = length(var.cost_center) >= 2 && length(var.cost_center) <= 30
    error_message = "Cost center must be between 2 and 30 characters."
  }
}

variable "managed_by" {
  description = "Tool or team managing the resource"
  type        = string
  default     = "terraform"
}

variable "project" {
  description = "Project name or identifier"
  type        = string
  default     = null
}

variable "owner" {
  description = "Owner email or team contact"
  type        = string
  default     = null

  validation {
    condition = var.owner == null || can(
      regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.owner)
    ) || length(var.owner) <= 100
    error_message = "Owner must be a valid email address or team name (max 100 characters)."
  }
}

variable "business_unit" {
  description = "Business unit responsible for the resource"
  type        = string
  default     = null
}

variable "data_classification" {
  description = "Data classification level (e.g., Public, Internal, Confidential, Restricted)"
  type        = string
  default     = null

  validation {
    condition = var.data_classification == null || contains(
      ["Public", "Internal", "Confidential", "Restricted", "Highly Confidential"],
      var.data_classification
    )
    error_message = "Data classification must be one of: Public, Internal, Confidential, Restricted, Highly Confidential."
  }
}

variable "compliance" {
  description = "Compliance requirements (e.g., HIPAA, SOC2, GDPR, PCI-DSS)"
  type        = string
  default     = null
}

variable "disaster_recovery" {
  description = "Disaster recovery tier (e.g., tier1, tier2, tier3)"
  type        = string
  default     = null

  validation {
    condition = var.disaster_recovery == null || contains(
      ["tier1", "tier2", "tier3", "none"],
      lower(var.disaster_recovery)
    )
    error_message = "Disaster recovery tier must be one of: tier1, tier2, tier3, none."
  }
}

variable "custom_tags" {
  description = "Additional custom tags to merge with standard tags"
  type        = map(string)
  default     = {}

  validation {
    condition     = length(var.custom_tags) <= 50
    error_message = "Maximum 50 custom tags allowed."
  }
}
