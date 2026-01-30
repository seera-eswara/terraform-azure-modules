variable "name" {
  description = "The name of the Action Group"
  type        = string

  validation {
    condition     = length(var.name) > 0 && length(var.name) <= 260
    error_message = "name must be between 1 and 260 characters."
  }
}

variable "location" {
  description = "Azure region for deployment (typically global)"
  type        = string
  default     = "global"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "short_name" {
  description = "Short name for the Action Group (used in alerts)"
  type        = string

  validation {
    condition     = length(var.short_name) <= 12
    error_message = "short_name must be 12 characters or less."
  }
}

variable "enabled" {
  description = "Whether the action group is enabled"
  type        = bool
  default     = true
}

variable "email_receivers" {
  description = "Email receivers for the action group"
  type = map(object({
    email_address            = string
    use_common_alert_schema  = optional(bool, true)
  }))
  default = {}
}

variable "webhook_receivers" {
  description = "Webhook receivers for the action group"
  type = map(object({
    service_uri              = string
    use_common_alert_schema  = optional(bool, true)
  }))
  default = {}
}

variable "sms_receivers" {
  description = "SMS receivers for the action group"
  type = map(object({
    country_code = string
    phone_number = string
  }))
  default = {}
}

variable "push_notification_receivers" {
  description = "Push notification receivers for the action group"
  type = map(object({
    email_address = string
  }))
  default = {}
}

variable "itsm_receivers" {
  description = "ITSM receivers for the action group"
  type = map(object({
    workspace_id         = string
    connection_id        = string
    ticket_configuration = string
    region               = string
  }))
  default = {}
}

variable "azure_function_receivers" {
  description = "Azure Function receivers for the action group"
  type = map(object({
    function_app_id          = string
    function_name            = string
    http_trigger_url         = string
    use_common_alert_schema  = optional(bool, true)
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to the action group"
  type        = map(string)
  default     = {}
}
