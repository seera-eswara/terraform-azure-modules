# SQL Database Module

This module creates and manages an Azure SQL Database with comprehensive security and monitoring features.

## Features

- Azure SQL Database provisioning
- Diagnostic settings and monitoring integration
- Role-based access control (RBAC)
- Geo-replication support
- Threat detection
- Automated backups
- Log Analytics integration

## Usage

```hcl
module "sql_database" {
  source = "./modules/sql_database"

  server_id                      = azurerm_mssql_server.example.id
  database_name                  = "myappdb"
  sku_name                       = "S0"
  collation                      = "SQL_Latin1_General_CP1_CI_AS"
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.example.id
}
```

## Variables

- `server_id` - The ID of the MSSQL Server
- `database_name` - The name of the SQL Database
- `sku_name` - The SKU name for the database
- `collation` - The collation of the database
- `log_analytics_workspace_id` - The ID of the Log Analytics workspace

## Outputs

- `id` - The ID of the created database
- `name` - The name of the created database
