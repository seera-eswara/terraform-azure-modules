# Role Assignment Module

This module creates and manages Azure Role-Based Access Control (RBAC) role assignments for principals.

## Features

- Flexible scope configuration
- Support for built-in and custom roles
- Principal ID validation
- Role definition name or ID support
- Multiple scope options

## Usage

```hcl
module "role_assignment" {
  source = "./modules/role_assignment"

  principal_id         = azurerm_user_assigned_identity.example.principal_id
  role_definition_name = "Contributor"
  scope                = azurerm_resource_group.example.id
}
```

## Variables

- `principal_id` - The ID of the principal (user, service principal, group)
- `role_definition_name` - The name of the role to assign
- `scope` - The scope for the role assignment

## Outputs

- `id` - The ID of the role assignment
