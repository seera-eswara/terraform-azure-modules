# Azure Monitor Action Group
# Creates an action group for alert notifications and actions

resource "azurerm_monitor_action_group" "ag" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  short_name          = var.short_name

  enabled = var.enabled

  # Email notifications
  dynamic "email_receiver" {
    for_each = var.email_receivers
    content {
      name           = email_receiver.key
      email_address  = email_receiver.value.email_address
      use_common_alert_schema = try(email_receiver.value.use_common_alert_schema, true)
    }
  }

  # Webhook notifications
  dynamic "webhook_receiver" {
    for_each = var.webhook_receivers
    content {
      name                    = webhook_receiver.key
      service_uri             = webhook_receiver.value.service_uri
      use_common_alert_schema = try(webhook_receiver.value.use_common_alert_schema, true)
    }
  }

  # SMS notifications
  dynamic "sms_receiver" {
    for_each = var.sms_receivers
    content {
      name = sms_receiver.key
      country_code = sms_receiver.value.country_code
      phone_number = sms_receiver.value.phone_number
    }
  }

  # Push notifications
  dynamic "push_notification_receiver" {
    for_each = var.push_notification_receivers
    content {
      name          = push_notification_receiver.key
      email_address = push_notification_receiver.value.email_address
    }
  }

  # ITSM notifications
  dynamic "itsm_receiver" {
    for_each = var.itsm_receivers
    content {
      name                 = itsm_receiver.key
      workspace_id         = itsm_receiver.value.workspace_id
      connection_id        = itsm_receiver.value.connection_id
      ticket_configuration = itsm_receiver.value.ticket_configuration
      region               = itsm_receiver.value.region
    }
  }

  # Azure Functions receiver
  dynamic "azure_function_receiver" {
    for_each = var.azure_function_receivers
    content {
      name             = azure_function_receiver.key
      function_app_id  = azure_function_receiver.value.function_app_id
      function_name    = azure_function_receiver.value.function_name
      http_trigger_url = azure_function_receiver.value.http_trigger_url
      use_common_alert_schema = try(azure_function_receiver.value.use_common_alert_schema, true)
    }
  }

  tags = var.tags
}
