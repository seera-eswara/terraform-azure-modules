# Azure Cosmos DB Account
# Creates a globally distributed database account with security features

resource "azurerm_cosmosdb_account" "cosmos" {
  name                      = var.name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  offer_type                = var.offer_type
  kind                      = var.kind
  
  # Enable managed identity
  identity {
    type = "SystemAssigned"
  }

  # Configure consistency policy
  consistency_policy {
    consistency_level       = var.consistency_level
    max_interval_in_seconds = var.max_interval_in_seconds
    max_staleness_prefix    = var.max_staleness_prefix
  }

  # Enable firewall
  ip_range_filter = join(",", concat(["127.0.0.1"], var.allowed_ip_addresses))
  is_virtual_network_filter_enabled = var.enable_vnet_filter

  # Enable automatic failover
  automatic_failover_enabled = var.automatic_failover_enabled

  # Virtual network rules (if vnet filtering enabled)
  dynamic "virtual_network_rule" {
    for_each = var.virtual_network_rule_ids
    content {
      id = virtual_network_rule.value
    }
  }

  # Capability configuration
  capabilities = var.capabilities

  # Backup configuration
  backup {
    type                = var.backup_type
    interval_in_minutes = var.backup_interval_minutes
    retention_in_hours  = var.backup_retention_hours
  }

  tags = var.tags

  depends_on = [
    azurerm_resource_group_resource_provider_registration.cosmos
  ]
}

# Register Cosmos DB resource provider
resource "azurerm_resource_group_resource_provider_registration" "cosmos" {
  resource_provider = "Microsoft.DocumentDB"
}

# Private Endpoint for Cosmos DB (if enabled)
resource "azurerm_private_endpoint" "cosmos_pe" {
  count               = var.create_private_endpoint ? 1 : 0
  name                = "${var.name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.name}-psc"
    private_connection_resource_id = azurerm_cosmosdb_account.cosmos.id
    subresource_names              = ["Sql"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "${var.name}-dns"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  tags = var.tags
}

# Diagnostic Settings for Cosmos DB
resource "azurerm_monitor_diagnostic_setting" "cosmos_diagnostics" {
  count                      = var.log_analytics_workspace_id != "" ? 1 : 0
  name                       = "${var.name}-diagnostics"
  target_resource_id         = azurerm_cosmosdb_account.cosmos.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  # Enabled logs
  dynamic "enabled_log" {
    for_each = var.enabled_logs
    content {
      category = enabled_log.value
    }
  }

  # Metrics
  metric {
    category = "AllMetrics"
    enabled  = var.metrics_enabled
  }
}

# Auto-scaling configuration (if using provisioned throughput)
resource "azurerm_cosmosdb_sql_database" "main_db" {
  account_name        = azurerm_cosmosdb_account.cosmos.name
  resource_group_name = var.resource_group_name
  name                = var.database_name

  dynamic "autoscale_settings" {
    for_each = var.autoscale_max_throughput != null ? [1] : []
    content {
      max_throughput = var.autoscale_max_throughput
    }
  }

  dynamic "throughput" {
    for_each = var.autoscale_max_throughput == null && var.throughput != null ? [1] : []
    content {
      throughput = var.throughput
    }
  }
}
