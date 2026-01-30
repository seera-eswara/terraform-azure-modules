# Log Analytics Workspace Module

This module creates and manages Azure Log Analytics workspaces for monitoring and analytics.

## Features

- Log Analytics workspace provisioning
- Retention configuration
- CMK encryption support
- Daily quota management
- RBAC support
- Internet ingestion and query settings

## Usage

```hcl
module "log_analytics_workspace" {
  source = "./modules/log_analytics_workspace"

  name                = "myworkspace"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "PerGB2018"
  retention_days      = 30
}
```

## Variables

- `name` - The name of the workspace
- `location` - Azure region for deployment
- `resource_group_name` - Name of the resource group
- `sku` - The SKU of the workspace
- `retention_days` - Data retention in days

## Outputs

- `id` - The ID of the workspace
- `workspace_id` - The workspace ID (legacy)
- `primary_shared_key` - Primary shared key for authentication
