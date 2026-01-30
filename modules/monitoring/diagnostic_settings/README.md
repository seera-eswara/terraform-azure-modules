# Diagnostic Settings Module

This module creates and manages Azure Monitor diagnostic settings for resource logging and monitoring.

## Features

- Flexible log and metric categories
- Log Analytics workspace integration
- Event Hub support
- Storage account support
- Selective category enabling

## Usage

```hcl
module "diagnostic_settings" {
  source = "./modules/diagnostic_settings"

  name                           = "myresource-diagnostics"
  target_resource_id             = azurerm_app_service.example.id
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.example.id
  enabled_logs                   = ["AppServiceHTTPLogs", "AppServiceEnvironmentPlatformLogs"]
  metrics_enabled                = true
}
```

## Variables

- `name` - The name of the diagnostic setting
- `target_resource_id` - The ID of the resource to apply diagnostics to
- `log_analytics_workspace_id` - Log Analytics workspace ID
- `enabled_logs` - List of log categories to enable
- `metrics_enabled` - Whether to enable metrics

## Outputs

- `id` - The ID of the diagnostic setting
- `name` - The name of the diagnostic setting
