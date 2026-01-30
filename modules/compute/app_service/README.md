# App Service Module

Deploys and manages Azure App Service with built-in security, monitoring, and networking features.

## Features

- Automatic resource naming based on CAF standards
- System-assigned managed identity
- Integrated Application Insights
- Diagnostic settings for monitoring
- Private endpoint support
- Network restrictions
- Automatic tagging
- Built-in HTTPS enforcement

## Usage

```hcl
module "app_service" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/app_service"

  name                = "myapp"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  app_service_plan_id = module.app_service_plan.id

  os_type = "Linux"  # or "Windows"

  # Networking
  private_endpoint_subnet_id = azurerm_subnet.private_endpoints.id
  create_private_endpoint    = true

  # Monitoring
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  enable_diagnostics         = true

  # Application settings
  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = module.app_insights.instrumentation_key
    "WEBSITE_RUN_FROM_PACKAGE"      = "1"
  }

  tags = {
    Environment = "prod"
    Owner       = "app-team"
  }
}
```

## Variables

| Name | Type | Required | Default | Description |
|------|------|----------|---------|-------------|
| `name` | string | Yes | - | Name of the App Service |
| `location` | string | Yes | - | Azure region |
| `resource_group_name` | string | Yes | - | Resource group name |
| `app_service_plan_id` | string | Yes | - | ID of App Service Plan |
| `os_type` | string | No | "Linux" | OS type: Linux or Windows |
| `private_endpoint_subnet_id` | string | No | null | Subnet for private endpoint |
| `create_private_endpoint` | bool | No | false | Create private endpoint |
| `log_analytics_workspace_id` | string | No | null | Log Analytics workspace ID |
| `enable_diagnostics` | bool | No | true | Enable diagnostic settings |
| `app_settings` | map(string) | No | {} | Application settings |
| `tags` | map(string) | No | {} | Resource tags |

## Outputs

- `id` - App Service ID
- `name` - App Service name
- `default_hostname` - Default hostname
- `identity_principal_id` - Managed identity principal ID
- `outbound_ip_addresses` - Outbound IP addresses
