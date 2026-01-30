# Azure Monitor Diagnostic Setting
# Configures monitoring and logging for Azure resources

resource "azurerm_monitor_diagnostic_setting" "diagnostics" {
  name                           = var.name
  target_resource_id             = var.target_resource_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id != "" ? var.log_analytics_workspace_id : null
  eventhub_authorization_rule_id = var.eventhub_authorization_rule_id != "" ? var.eventhub_authorization_rule_id : null
  storage_account_id             = var.storage_account_id != "" ? var.storage_account_id : null

  # Enabled logs with flexible categories
  dynamic "enabled_log" {
    for_each = var.enabled_logs
    content {
      category = enabled_log.value
    }
  }

  # Metrics configuration
  dynamic "metric" {
    for_each = var.metrics_enabled ? [1] : []
    content {
      category = "AllMetrics"
      enabled  = true
    }
  }

  # Additional metric categories
  dynamic "metric" {
    for_each = var.specific_metrics
    content {
      category = metric.value
      enabled  = true
    }
  }

  # Retention policy for storage account
  dynamic "log" {
    for_each = var.log_retention_days != 0 ? [1] : []
    content {
      category       = "*"
      enabled        = true
      retention_days = var.log_retention_days
    }
  }
}
