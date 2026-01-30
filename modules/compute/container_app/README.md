# Container App Module

Deploys Azure Container Apps with environment, networking, and monitoring.

## Features

- Container Apps Environment creation
- Multi-container support
- Environment variables and secrets
- VNet integration
- Managed identity
- Diagnostic settings
- Auto-scaling configuration

## Usage

```hcl
module "container_app" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/container_app"

  name                        = "myapp"
  location                    = "eastus"
  resource_group_name         = azurerm_resource_group.this.name
  container_app_environment_id = module.container_app_env.id
  
  image           = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
  cpu             = "0.25"
  memory          = "0.5Gi"
  port            = 80
  
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
}
```

## Outputs

- `id` - Container App ID
- `fqdn` - FQDN of the app
- `identity_principal_id` - Managed identity principal ID
