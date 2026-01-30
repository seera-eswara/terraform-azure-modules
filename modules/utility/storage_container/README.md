# Azure Storage Container Module

Terraform module for creating Azure Storage Containers with access control and metadata.

## Features

- Container access level management (private, blob, container)
- Metadata support
- Integration with storage accounts
- Consistent naming

## Usage

```hcl
module "storage_container" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/storage_container"
  
  name                  = "data"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
  
  metadata = {
    purpose = "application-data"
  }
}
```

## Multiple Containers

```hcl
module "containers" {
  source   = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/storage_container"
  for_each = toset(["uploads", "processed", "archive"])
  
  name                  = each.key
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.6.6 |
| azurerm | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 4.0 |

## Resources

| Name | Type |
|------|------|
| azurerm_storage_container.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Container name | `string` | n/a | yes |
| storage_account_name | Storage account name | `string` | n/a | yes |
| container_access_type | Access level (private, blob, container) | `string` | `"private"` | no |
| metadata | Metadata key-value pairs | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Container ID |
| name | Container name |
| resource_manager_id | Resource Manager ID |
