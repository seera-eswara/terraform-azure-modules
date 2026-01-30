# Azure Virtual Network Module

Terraform module for creating Azure Virtual Networks with DNS, subnets, and peering support.

## Features

- Custom DNS servers
- Multiple subnets support
- Service endpoints
- DDoS protection (optional)
- Diagnostic settings integration
- VNet peering ready
- Tags support

## Usage

### Basic VNet

```hcl
module "vnet" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/networking/vnet"
  
  name                = "vnet-myapp-prod"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.0.0.0/16"]
  
  tags = {
    Environment = "production"
  }
}
```

### VNet with Subnets

```hcl
module "vnet" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/networking/vnet"
  
  name                = "vnet-myapp-prod"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  address_space       = ["10.0.0.0/16"]
  
  subnets = {
    "app" = {
      address_prefixes  = ["10.0.1.0/24"]
      service_endpoints = ["Microsoft.Storage", "Microsoft.KeyVault"]
    }
    "data" = {
      address_prefixes  = ["10.0.2.0/24"]
      service_endpoints = ["Microsoft.Sql", "Microsoft.Storage"]
    }
  }
  
  enable_diagnostics         = true
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  
  tags = {
    Environment = "production"
  }
}
```

### Hub VNet with DNS

```hcl
module "hub_vnet" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/networking/vnet"
  
  name                = "vnet-hub-prod"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.hub.name
  address_space       = ["10.100.0.0/16"]
  
  dns_servers = ["10.100.1.4", "10.100.1.5"]
  
  subnets = {
    "firewall" = {
      address_prefixes = ["10.100.0.0/26"]
    }
    "gateway" = {
      address_prefixes = ["10.100.1.0/24"]
    }
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
| azurerm_virtual_network.this | resource |
| azurerm_subnet.this | resource |
| azurerm_monitor_diagnostic_setting.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | VNet name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| resource_group_name | Resource group name | `string` | n/a | yes |
| address_space | Address space CIDR blocks | `list(string)` | n/a | yes |
| dns_servers | Custom DNS servers | `list(string)` | `[]` | no |
| subnets | Subnet configurations | `map(object)` | `{}` | no |
| enable_diagnostics | Enable diagnostic settings | `bool` | `false` | no |
| log_analytics_workspace_id | Log Analytics workspace ID | `string` | `null` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | VNet ID |
| name | VNet name |
| address_space | VNet address space |
| subnet_ids | Map of subnet names to IDs |
| subnets | Complete subnet objects |
