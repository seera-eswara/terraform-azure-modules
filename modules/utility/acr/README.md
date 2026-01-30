# Azure Container Registry Module

Terraform module for creating Azure Container Registry with security features.

## Features

- SKU-based configuration (Basic, Standard, Premium)
- Admin user management
- Geo-replication (Premium SKU)
- Network rules and private endpoints (Premium SKU)
- Managed identity support
- Diagnostic settings integration
- Retention policies
- Content trust

## Usage

### Basic Registry

```hcl
module "acr" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/acr"
  
  name                = "myacr"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Basic"
  
  tags = {
    Environment = "dev"
  }
}
```

### Premium with Private Endpoint

```hcl
module "acr" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/acr"
  
  name                = "myacr"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Premium"
  
  enable_admin_user = false
  
  network_rule_set = {
    default_action = "Deny"
    ip_rules       = ["1.2.3.4/32"]
    virtual_network_rules = [
      {
        subnet_id = azurerm_subnet.aks.id
      }
    ]
  }
  
  create_private_endpoint    = true
  private_endpoint_subnet_id = azurerm_subnet.private_endpoints.id
  
  enable_diagnostics         = true
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  
  retention_policy = {
    enabled = true
    days    = 30
  }
  
  tags = {
    Environment = "production"
  }
}
```

### With Geo-Replication

```hcl
module "acr" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/acr"
  
  name                = "myacr"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Premium"
  
  georeplications = [
    {
      location                = "westus2"
      zone_redundancy_enabled = true
    },
    {
      location                = "westeurope"
      zone_redundancy_enabled = true
    }
  ]
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
| azurerm_container_registry.this | resource |
| azurerm_private_endpoint.this | resource |
| azurerm_monitor_diagnostic_setting.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Registry name (globally unique) | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| resource_group_name | Resource group name | `string` | n/a | yes |
| sku | SKU (Basic, Standard, Premium) | `string` | `"Standard"` | no |
| enable_admin_user | Enable admin user | `bool` | `false` | no |
| network_rule_set | Network rule configuration | `object` | `null` | no |
| georeplications | Geo-replication locations (Premium only) | `list(object)` | `[]` | no |
| retention_policy | Retention policy | `object` | `null` | no |
| create_private_endpoint | Create private endpoint | `bool` | `false` | no |
| private_endpoint_subnet_id | Subnet ID for private endpoint | `string` | `null` | no |
| enable_diagnostics | Enable diagnostic settings | `bool` | `false` | no |
| log_analytics_workspace_id | Log Analytics workspace ID | `string` | `null` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Registry ID |
| name | Registry name |
| login_server | Registry login server |
| admin_username | Admin username (if enabled) |
| admin_password | Admin password (if enabled) |
| identity | Managed identity details |
