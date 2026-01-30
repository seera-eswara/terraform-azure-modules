# Cosmos DB Account Module

This module creates and manages an Azure Cosmos DB account with security, monitoring, and scalability features.

## Features

- Azure Cosmos DB account provisioning
- Private endpoint support
- Firewall configuration
- Diagnostic settings and monitoring
- Auto-scaling capabilities
- Multiple API support
- Managed identity integration

## Usage

```hcl
module "cosmos_account" {
  source = "./modules/cosmos_account"

  name                           = "mycosmosdb"
  location                       = "eastus"
  resource_group_name            = azurerm_resource_group.example.name
  kind                           = "GlobalDocumentDB"
  offer_type                     = "Standard"
  create_private_endpoint        = true
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.example.id
}
```

## Variables

- `name` - The name of the Cosmos DB account
- `location` - Azure region for deployment
- `resource_group_name` - Name of the resource group
- `kind` - Type of Cosmos DB (GlobalDocumentDB, MongoDB, etc.)
- `offer_type` - Offer type (Standard or Premium)
- `create_private_endpoint` - Whether to create a private endpoint
- `log_analytics_workspace_id` - Log Analytics workspace ID

## Outputs

- `id` - The ID of the Cosmos DB account
- `endpoint` - The endpoint used to connect to Cosmos DB
- `primary_key` - The primary master key for authentication
