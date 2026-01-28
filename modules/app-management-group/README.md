# App Management Group Module

Creates a management group for a specific application with consistent naming pattern.

## Usage

```hcl
module "rff_app_mg" {
  source = "git::https://github.com/seera-eswara/terraform-azure-modules.git//modules/app-management-group?ref=main"

  app_code                   = "RFF"
  parent_management_group_id = data.azurerm_management_group.applications.id

  app_owners       = ["owner-uuid-1", "owner-uuid-2"]
  app_contributors = ["contributor-uuid-1"]
}
```

## Features

- Creates app-specific management group: `mg-{app_code}` (display: `MG-{APP_CODE}`)
- Assigns RBAC roles at management group level
- Supports multiple owners and contributors
- Returns MG details for subscription association

## Inputs

| Name | Description | Type | Required |
|------|-------------|------|----------|
| `app_code` | Application code (e.g., RFF, APP, CRM) | string | Yes |
| `parent_management_group_id` | ID of parent MG (Applications MG) | string | Yes |
| `app_owners` | Principal IDs for MG owners | list(string) | No |
| `app_contributors` | Principal IDs for MG contributors | list(string) | No |

## Outputs

| Name | Description |
|------|-------------|
| `management_group_id` | Full resource ID of the app MG |
| `management_group_name` | Resource name (mg-{app_code}) |
| `management_group_display_name` | Display name (MG-{APP_CODE}) |

## Example

Creates `MG-RFF` management group under Applications:

```hcl
module "app_mg" {
  source = "git::https://github.com/seera-eswara/terraform-azure-modules.git//modules/app-management-group?ref=main"

  app_code                   = "RFF"
  parent_management_group_id = "/providers/Microsoft.Management/managementGroups/applications"
  
  app_owners = [
    "11111111-1111-1111-1111-111111111111"
  ]
}
```

## Architecture Context

This module is called by **terraform-azure-subscription-factory** to create app-specific management groups on-demand during subscription provisioning. This keeps the landing zone stable while enabling self-service for app teams.
