# App Service Plan Module

Manages Azure App Service Plans with configurable SKU, auto-scaling, and monitoring.

## Features

- Support for Windows, Linux, and Consumption plans
- Auto-scaling configuration
- Diagnostic settings
- Automatic tagging
- Zone redundancy support

## Usage

```hcl
module "app_service_plan" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/app_service_plan"

  name                = "myplan"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  
  os_type = "Linux"
  sku_tier = "Standard"
  sku_size = "S1"
  
  reserved = true  # Required for Linux
  
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  
  tags = {
    Environment = "prod"
  }
}
```

## Outputs

- `id` - App Service Plan ID
- `name` - App Service Plan name
- `maximum_worker_count` - Maximum worker count
