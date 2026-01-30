# Azure Functions Module

Deploys Azure Functions with runtime support, monitoring, and networking integration.

## Features

- Support for multiple runtimes (Node, Python, Java, PowerShell, Custom)
- Managed identity
- Application Insights integration
- Private endpoint support
- Diagnostic settings
- Storage account integration

## Usage

```hcl
module "function_app" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/function_app"

  name                       = "myfunction"
  location                   = "eastus"
  resource_group_name        = azurerm_resource_group.this.name
  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key
  app_service_plan_id        = module.app_service_plan.id
  
  runtime_version = "4"
  runtime_name    = "node"
  
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = module.app_insights.instrumentation_key
  }
}
```

## Outputs

- `id` - Function App ID
- `default_hostname` - Default hostname
- `identity_principal_id` - Managed identity principal ID
