# Action Group Module

This module creates and manages Azure Monitor Action Groups for alert notifications and actions.

## Features

- Action Group provisioning
- Email notifications
- Webhook notifications
- SMS and push notifications
- ITSM integration
- Flexible notification routing

## Usage

```hcl
module "action_group" {
  source = "./modules/action_group"

  name                = "myapp-alerts"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.example.name
  short_name          = "myalerts"

  email_receivers = {
    admin = {
      email_address = "admin@example.com"
    }
  }
}
```

## Variables

- `name` - The name of the action group
- `location` - Azure region for deployment
- `resource_group_name` - Name of the resource group
- `short_name` - Short name for alerts
- `email_receivers` - Email notification receivers
- `webhook_receivers` - Webhook action receivers

## Outputs

- `id` - The ID of the action group
- `name` - The name of the action group
