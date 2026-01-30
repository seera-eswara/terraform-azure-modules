# Azure Resource Group Module

Terraform module for creating Azure Resource Groups with consistent naming and tagging.

## Features

- Consistent naming conventions
- Standardized tagging
- Location validation
- Optional locks (CanNotDelete, ReadOnly)
- Outputs for integration

## Usage

```hcl
module "resource_group" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/resource_group"
  
  name     = "rg-myapp-dev"
  location = "eastus"
  
  tags = {
    Environment = "dev"
    Application = "myapp"
    CostCenter  = "IT"
  }
}
```

## With Lock

```hcl
module "resource_group" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/resource_group"
  
  name     = "rg-myapp-prod"
  location = "eastus"
  
  create_lock = true
  lock_level  = "CanNotDelete"
  
  tags = {
    Environment = "production"
    Application = "myapp"
  }
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
| azurerm_resource_group.this | resource |
| azurerm_management_lock.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the resource group | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| tags | Tags to apply | `map(string)` | `{}` | no |
| create_lock | Create management lock | `bool` | `false` | no |
| lock_level | Lock level (CanNotDelete or ReadOnly) | `string` | `"CanNotDelete"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Resource group ID |
| name | Resource group name |
| location | Resource group location |
| tags | Resource group tags |
