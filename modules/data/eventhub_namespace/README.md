# Event Hub Namespace Module

This module creates and manages an Azure Event Hub namespace with security, monitoring, and messaging features.

## Features

- Azure Event Hub namespace provisioning
- Private endpoint support
- Firewall configuration
- Diagnostic settings and monitoring
- Managed identity integration
- Auto-scaling capabilities
- RBAC support

## Usage

```hcl
module "eventhub_namespace" {
  source = "./modules/eventhub_namespace"

  name                           = "myeventhubns"
  location                       = "eastus"
  resource_group_name            = azurerm_resource_group.example.name
  sku                            = "Standard"
  capacity                       = 2
  create_private_endpoint        = true
}
```

## Variables

- `name` - The name of the Event Hub namespace
- `location` - Azure region for deployment
- `resource_group_name` - Name of the resource group
- `sku` - The SKU of the namespace
- `capacity` - The capacity of the namespace
- `create_private_endpoint` - Whether to create a private endpoint

## Outputs

- `id` - The ID of the Event Hub namespace
- `name` - The name of the namespace
- `connection_string` - The connection string for the namespace
