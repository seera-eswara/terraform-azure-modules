# Azure Tags Utility Module

Terraform module for generating consistent, standardized tags across Azure resources.

## Features

- Standardized tag generation
- Mandatory tags enforcement
- Environment-specific tags
- Cost center tracking
- Project/application tagging
- Merge with custom tags
- CAF (Cloud Adoption Framework) aligned

## Usage

### Basic Tags

```hcl
module "tags" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/tags"
  
  environment = "production"
  application = "web-portal"
  cost_center = "IT-OPS"
  managed_by  = "terraform"
}

resource "azurerm_resource_group" "this" {
  name     = "rg-webportal-prod"
  location = "eastus"
  tags     = module.tags.tags
}
```

### With Custom Tags

```hcl
module "tags" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/tags"
  
  environment = "dev"
  application = "analytics"
  cost_center = "DATA-ENG"
  
  custom_tags = {
    DataClassification = "Confidential"
    Compliance         = "GDPR"
    BackupPolicy       = "Daily"
  }
}
```

### For Multiple Environments

```hcl
locals {
  environments = ["dev", "stage", "prod"]
}

module "tags" {
  source   = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/tags"
  for_each = toset(local.environments)
  
  environment = each.key
  application = "api-gateway"
  cost_center = "PLATFORM"
  project     = "modernization-2026"
}
```

### Full Configuration

```hcl
module "tags" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/tags"
  
  environment        = "production"
  application        = "customer-portal"
  cost_center        = "CUSTOMER-OPS"
  project            = "digital-transformation"
  owner              = "platform-team@company.com"
  business_unit      = "Customer Success"
  data_classification = "Internal"
  compliance         = "SOC2,HIPAA"
  disaster_recovery  = "tier1"
  managed_by         = "terraform"
  
  custom_tags = {
    MaintenanceWindow = "Sunday 02:00-04:00 UTC"
    SLA               = "99.95"
    SupportTeam       = "platform-ops"
  }
}
```

## Tag Standards

The module generates the following standard tags:

| Tag | Description | Example |
|-----|-------------|---------|
| Environment | Deployment environment | production, staging, dev |
| Application | Application name | web-portal, api-gateway |
| CostCenter | Cost allocation | IT-OPS, DATA-ENG |
| ManagedBy | Management tool | terraform, manual |
| Project | Project identifier | modernization-2026 |
| Owner | Owner contact | team@company.com |
| BusinessUnit | Business unit | Customer Success |
| DataClassification | Data sensitivity | Public, Internal, Confidential |
| Compliance | Compliance requirements | SOC2, HIPAA, GDPR |
| DisasterRecovery | DR tier | tier1, tier2, tier3 |
| CreatedDate | Resource creation date | 2026-01-29 |

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.6.6 |

## Providers

No providers required (utility module)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | Environment name | `string` | n/a | yes |
| application | Application name | `string` | n/a | yes |
| cost_center | Cost center code | `string` | n/a | yes |
| managed_by | Management method | `string` | `"terraform"` | no |
| project | Project name | `string` | `null` | no |
| owner | Owner contact | `string` | `null` | no |
| business_unit | Business unit | `string` | `null` | no |
| data_classification | Data classification | `string` | `null` | no |
| compliance | Compliance requirements | `string` | `null` | no |
| disaster_recovery | DR tier | `string` | `null` | no |
| custom_tags | Additional custom tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| tags | Complete tag map |
| mandatory_tags | Mandatory tags only |
| optional_tags | Optional tags only |

## Best Practices

1. **Mandatory Tags**: Always provide environment, application, and cost_center
2. **Consistency**: Use the same tag keys across all resources
3. **Cost Tracking**: Use cost_center for charge-back/show-back
4. **Compliance**: Tag sensitive workloads with data_classification
5. **Automation**: Reference module outputs in all resource definitions
6. **Updates**: Update tags when requirements change

## Examples

### Tag Policy Enforcement

```hcl
# Enforce tags at subscription level
resource "azurerm_subscription_policy_assignment" "tags" {
  name                 = "enforce-tags"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/..."
  
  parameters = jsonencode({
    tagNames = {
      value = ["Environment", "Application", "CostCenter", "ManagedBy"]
    }
  })
}
```

### Cost Reporting Query

```kql
// Query resources by cost center
Resources
| where tags['CostCenter'] == 'IT-OPS'
| where tags['Environment'] == 'production'
| project name, type, resourceGroup, location, tags
```
