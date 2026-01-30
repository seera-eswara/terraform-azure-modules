# Private DNS Zone Link Module

This module creates and manages Azure Private DNS Zone virtual network links for private name resolution.

## Features

- Private DNS zone virtual network link provisioning
- Auto-registration support
- Multiple virtual network support
- Registration record management

## Usage

```hcl
module "private_dns_zone_link" {
  source = "./modules/private_dns_zone_link"

  name                = "link-dev"
  private_dns_zone_id = azurerm_private_dns_zone.example.id
  virtual_network_id  = azurerm_virtual_network.example.id
  registration_enabled = true
}
```

## Variables

- `name` - The name of the link
- `private_dns_zone_id` - The ID of the private DNS zone
- `virtual_network_id` - The ID of the virtual network
- `registration_enabled` - Whether to enable auto-registration

## Outputs

- `id` - The ID of the link
- `name` - The name of the link
