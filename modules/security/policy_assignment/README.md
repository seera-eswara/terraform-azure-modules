# Policy Assignment Module

This module creates and manages Azure Policy assignments at management group scope for governance and compliance.

## Features

- Policy assignment provisioning
- Management group scope support
- Enforcement mode configuration
- Identity assignment support
- Parameters and exclusions

## Usage

```hcl
module "policy_assignment" {
  source = "./modules/policy_assignment"

  policy_definition_id  = azurerm_policy_definition.example.id
  management_group_id   = azurerm_management_group.example.id
  enforcement_mode      = "Default"
}
```

## Variables

- `policy_definition_id` - The ID of the policy definition
- `management_group_id` - The management group ID for assignment
- `enforcement_mode` - The enforcement mode (Default or DoNotEnforce)

## Outputs

- `id` - The ID of the policy assignment
- `name` - The name of the policy assignment
