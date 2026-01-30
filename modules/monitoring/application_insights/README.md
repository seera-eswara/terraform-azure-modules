# Azure Application Insights Module

Terraform module for creating Azure Application Insights with Log Analytics integration.

## Features

- Application type support (web, mobile, other)
- Log Analytics workspace integration
- Retention configuration
- IP masking
- Sampling percentage control
- Tags support

## Usage

### Basic Application Insights

```hcl
module "app_insights" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/monitoring/application_insights"
  
  name                = "appi-myapp-prod"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  workspace_id        = azurerm_log_analytics_workspace.this.id
  application_type    = "web"
  
  tags = {
    Environment = "production"
  }
}
```

### With Custom Configuration

```hcl
module "app_insights" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/monitoring/application_insights"
  
  name                = "appi-myapp-prod"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  workspace_id        = azurerm_log_analytics_workspace.this.id
  application_type    = "web"
  
  retention_in_days          = 90
  daily_data_cap_in_gb       = 100
  sampling_percentage        = 100
  disable_ip_masking         = false
  
  tags = {
    Environment = "production"
    Application = "web-portal"
  }
}
```

### Mobile Application

```hcl
module "mobile_insights" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/monitoring/application_insights"
  
  name                = "appi-mobile-prod"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  workspace_id        = azurerm_log_analytics_workspace.this.id
  application_type    = "ios"
  
  tags = {
    Platform = "iOS"
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
| azurerm_application_insights.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Application Insights name | `string` | n/a | yes |
| location | Azure region | `string` | n/a | yes |
| resource_group_name | Resource group name | `string` | n/a | yes |
| workspace_id | Log Analytics workspace ID | `string` | n/a | yes |
| application_type | Application type | `string` | `"web"` | no |
| retention_in_days | Data retention in days | `number` | `90` | no |
| daily_data_cap_in_gb | Daily data cap in GB | `number` | `null` | no |
| sampling_percentage | Sampling percentage | `number` | `100` | no |
| disable_ip_masking | Disable IP masking | `bool` | `false` | no |
| tags | Resource tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Application Insights ID |
| app_id | Application ID |
| instrumentation_key | Instrumentation key (sensitive) |
| connection_string | Connection string (sensitive) |
