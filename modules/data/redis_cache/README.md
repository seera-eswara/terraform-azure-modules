# Redis Cache Module

This module creates and manages an Azure Cache for Redis with security, monitoring, and advanced caching features.

## Features

- Azure Cache for Redis provisioning
- Private endpoint support
- Firewall configuration
- SSL/TLS enforcement
- Diagnostic settings and monitoring
- Cluster and replication options
- Managed identity integration

## Usage

```hcl
module "redis_cache" {
  source = "./modules/redis_cache"

  name                           = "myredis"
  location                       = "eastus"
  resource_group_name            = azurerm_resource_group.example.name
  family                         = "P"
  capacity                       = 1
  sku_name                       = "Premium"
  create_private_endpoint        = true
}
```

## Variables

- `name` - The name of the Redis cache
- `location` - Azure region for deployment
- `resource_group_name` - Name of the resource group
- `family` - The SKU family (C or P)
- `capacity` - The size of the Redis cache instance
- `sku_name` - The SKU of the Redis cache
- `create_private_endpoint` - Whether to create a private endpoint

## Outputs

- `id` - The ID of the Redis cache
- `hostname` - The hostname of the Redis cache
- `port` - The port of the Redis cache
- `primary_access_key` - The primary access key
