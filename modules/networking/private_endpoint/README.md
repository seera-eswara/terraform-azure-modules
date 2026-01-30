# Private Endpoint Module

This module creates and manages Azure Private Endpoints for secure, private connectivity to Azure services.

## Features

- Azure Private Endpoint provisioning
- Support for multiple subresources
- Private DNS zone integration
- Flexible resource targeting
- Naming conventions support
- Tags management

## Usage

```hcl
module "private_endpoint" {
  source = "./modules/private_endpoint"

  name                = "myresource-pe"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.example.id
  resource_id         = azurerm_key_vault.example.id
  subresources        = ["vault"]
}
```

## Variables

- `name` - The name of the private endpoint
- `location` - Azure region for deployment
- `resource_group_name` - Name of the resource group
- `subnet_id` - The ID of the subnet for the endpoint
- `resource_id` - The ID of the resource to connect to
- `subresources` - List of subresources for the connection

## Outputs

- `id` - The ID of the private endpoint
- `private_ip_address` - The private IP address
