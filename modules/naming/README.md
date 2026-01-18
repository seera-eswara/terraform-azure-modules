# Azure Naming Convention Module

Generates consistent, enterprise-grade resource names following Azure Cloud Adoption Framework (CAF) naming standards.

## Format

**Standard Resources:**
```
<resource-type>-<app-code>-<environment>-<region>-<instance>
```

**Storage Accounts:**
```
<type><appcode><env><region><instance>  (lowercase, no hyphens, max 24 chars)
```

## Usage

### Basic Example

```hcl
module "naming" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/naming"

  app_code    = "crm"
  environment = "prod"
  location    = "eastus"
}

resource "azurerm_resource_group" "this" {
  name     = module.naming.names.resource_group
  location = var.location
  tags     = module.naming.tags
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = module.naming.names.aks_cluster
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  # ... other config
  tags = module.naming.tags
}
```

### With Instance Number (Multiple Deployments)

```hcl
module "naming" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/naming"

  app_code    = "app"
  environment = "dev"
  location    = "eastus"
  instance    = 1  # Results in: rg-app-dev-eus-01
}
```

### With Additional Tags

```hcl
module "naming" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/naming"

  app_code    = "erp"
  environment = "prod"
  location    = "westeurope"

  additional_tags = {
    CostCenter = "CC-1234"
    Owner      = "finance-team@company.com"
    Compliance = "PCI-DSS"
  }
}
```

## Generated Names

| Resource Type | Example Output |
|--------------|----------------|
| Resource Group | `rg-crm-prod-eus-01` |
| AKS Cluster | `aks-crm-prod-eus-01` |
| Virtual Network | `vnet-crm-prod-eus-01` |
| Log Analytics | `law-crm-prod-eus-01` |
| Key Vault | `kv-crm-prod-eus-01` |
| Storage Account | `stcrmprodeus01` |
| SQL Server | `sql-crm-prod-eus-01` |
| Load Balancer | `lb-crm-prod-eus-01` |

## Region Abbreviations

| Region | Abbreviation | Region | Abbreviation |
|--------|-------------|--------|-------------|
| East US | `eus` | West Europe | `weu` |
| East US 2 | `eus2` | North Europe | `neu` |
| West US | `wus` | UK South | `uks` |
| Central US | `cus` | Japan East | `jpe` |
| Canada Central | `cac` | Australia East | `aue` |
| Southeast Asia | `sea` | South India | `ins` |

## Validation Rules

- **app_code**: Must be exactly 3 lowercase alphanumeric characters
- **environment**: Must be one of: `dev`, `stage`, `prod`, `qa`, `uat`
- **instance**: Optional, must be 1-99 if specified

## Outputs

- `names` - Map of all resource names
- `tags` - Standard tags object
- Individual outputs for common resources (resource_group, aks_cluster, etc.)

## Enterprise Benefits

1. **Consistency** - All teams follow the same pattern
2. **Discoverability** - Easy to find resources by app code
3. **Cost Tracking** - Chargeback by app code tag
4. **Automation** - Predictable naming for scripts
5. **Compliance** - Audit trail via standardized tags
