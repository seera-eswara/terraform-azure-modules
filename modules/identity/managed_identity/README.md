# Managed Identity Module

This module creates and manages Azure User Assigned Managed Identities for secure authentication.

## Features

- User Assigned Managed Identity provisioning
- Naming convention support
- Tags management
- Principal ID and Client ID outputs for RBAC

## Usage

```hcl
module "managed_identity" {
  source = "./modules/managed_identity"

  name                = "myapp-identity"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.example.name

  tags = {
    Environment = "production"
  }
}
```

## Variables

- `name` - The name of the managed identity
- `location` - Azure region for deployment
- `resource_group_name` - Name of the resource group
- `tags` - Tags to apply

## Outputs

- `id` - The ID of the managed identity
- `principal_id` - The principal ID for RBAC assignments
- `client_id` - The client ID for authentication
