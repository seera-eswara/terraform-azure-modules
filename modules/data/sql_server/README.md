# Azure SQL Server Module

Deploys Azure SQL Server with security hardening, networking, and compliance features.

## Features

- System-assigned managed identity
- Private endpoint support
- Firewall rules
- Transparent data encryption
- Auditing and threat detection
- Virtual network rules
- Admin authentication
- Diagnostic settings

## Usage

```hcl
module "sql_server" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/sql_server"

  name                = "myserver"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  
  administrator_login          = "sqladmin"
  administrator_login_password = random_password.sql_admin.result
  
  # Networking
  create_private_endpoint    = true
  private_endpoint_subnet_id = azurerm_subnet.data.id
  
  # Security
  enable_firewall = true
  firewall_rules = {
    "AllowAzureServices" = {
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }
  }
  
  # Monitoring
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
}
```

## Outputs

- `id` - SQL Server ID
- `fqdn` - Fully qualified domain name
- `identity_principal_id` - Managed identity principal ID
