# Service Bus Namespace Module

This module creates and manages an Azure Service Bus namespace with security, monitoring, and messaging features.

## Features

- Azure Service Bus namespace provisioning
- Private endpoint support
- Firewall configuration
- Diagnostic settings and monitoring
- Managed identity integration
- RBAC support
- Multiple SKU options

## Usage

```hcl
module "servicebus_namespace" {
  source = "./modules/servicebus_namespace"

  name                           = "myservicebusns"
  location                       = "eastus"
  resource_group_name            = azurerm_resource_group.example.name
  sku                            = "Standard"
  create_private_endpoint        = true
}
```

## Variables

- `name` - The name of the Service Bus namespace
- `location` - Azure region for deployment
- `resource_group_name` - Name of the resource group
- `sku` - The SKU of the namespace
- `create_private_endpoint` - Whether to create a private endpoint

## Outputs

- `id` - The ID of the Service Bus namespace
- `name` - The name of the namespace
- `connection_string` - The connection string for the namespace
