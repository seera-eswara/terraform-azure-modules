# Azure Storage Account Module

Deploys Azure Storage Account with security hardening, networking, and monitoring.

## Features

- Multiple redundancy options (LRS, GRS, ZRS, GZRS)
- Private endpoint support
- Firewall rules
- RBAC enforcement
- Diagnostic settings
- Blob versioning and soft delete
- HTTPS enforcement
- Managed identity support

## Usage

```hcl
module "storage_account" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/storage_account"

  name                = "mystorageacct"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  
  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_kind             = "StorageV2"
  
  https_traffic_only_enabled = true
  min_tls_version            = "TLS1_2"
  
  # Networking
  create_private_endpoint    = true
  private_endpoint_subnet_id = azurerm_subnet.private_endpoints.id
  
  # Security
  enable_firewall = true
  firewall_virtual_network_subnet_ids = [
    azurerm_subnet.app.id
  ]
  
  # Monitoring
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
}
```

## Outputs

- `id` - Storage account ID
- `name` - Storage account name
- `primary_blob_endpoint` - Primary blob endpoint
- `identity_principal_id` - Managed identity principal ID
