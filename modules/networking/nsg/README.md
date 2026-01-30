# Network Security Group Module

This module creates and manages Azure Network Security Groups with security rules and monitoring.

## Features

- Azure Network Security Group provisioning
- Flexible rule management
- Diagnostic settings and monitoring
- Comprehensive security rule templates
- Efficient rule organization

## Usage

```hcl
module "nsg" {
  source = "./modules/nsg"

  name                           = "myapp-nsg"
  location                       = "eastus"
  resource_group_name            = azurerm_resource_group.example.name
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.example.id

  rules = {
    allow_https = {
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}
```

## Variables

- `name` - The name of the NSG
- `location` - Azure region for deployment
- `resource_group_name` - Name of the resource group
- `rules` - Security rules to apply
- `log_analytics_workspace_id` - Log Analytics workspace ID

## Outputs

- `id` - The ID of the NSG
- `name` - The name of the NSG
