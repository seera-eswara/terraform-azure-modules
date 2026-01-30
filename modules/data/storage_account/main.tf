resource "azurerm_storage_account" "this" {
  name                             = var.name
  location                         = var.location
  resource_group_name              = var.resource_group_name
  account_tier                     = var.account_tier
  account_replication_type         = var.account_replication_type
  account_kind                     = var.account_kind
  access_tier                      = var.access_tier
  https_traffic_only_enabled       = var.https_traffic_only_enabled
  min_tls_version                  = var.min_tls_version
  infrastructure_encryption_enabled = true
  shared_access_key_enabled        = var.shared_access_key_enabled

  identity {
    type = "SystemAssigned"
  }

  dynamic "network_rules" {
    for_each = var.enable_firewall ? [1] : []
    content {
      default_action             = "Deny"
      bypass                     = ["AzureServices", "Logging", "Metrics"]
      virtual_network_subnet_ids = var.firewall_virtual_network_subnet_ids
      ip_rules                   = var.firewall_ip_rules
    }
  }

  tags = var.tags
}

# Blob properties (versioning, soft delete)
resource "azurerm_storage_account_blob_properties" "this" {
  storage_account_id = azurerm_storage_account.this.id

  versioning_enabled  = var.enable_blob_versioning
  change_feed_enabled = var.enable_change_feed

  dynamic "delete_retention_policy" {
    for_each = var.enable_soft_delete ? [1] : []
    content {
      days = var.soft_delete_retention_days
    }
  }

  dynamic "container_delete_retention_policy" {
    for_each = var.enable_container_soft_delete ? [1] : []
    content {
      days = var.container_soft_delete_retention_days
    }
  }
}

# Private endpoint
resource "azurerm_private_endpoint" "blob" {
  count               = var.create_private_endpoint ? 1 : 0
  name                = "${var.name}-blob-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.name}-blob-psc"
    private_connection_resource_id = azurerm_storage_account.this.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  tags = var.tags
}

# Diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "this" {
  count                      = var.enable_diagnostics && var.log_analytics_workspace_id != null ? 1 : 0
  name                       = "${var.name}-diag"
  target_resource_id         = "${azurerm_storage_account.this.id}/blobServices/default"
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = ["StorageRead", "StorageWrite", "StorageDelete"]
    content {
      category = enabled_log.value
      enabled  = true
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
