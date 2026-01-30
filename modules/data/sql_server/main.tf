resource "azurerm_mssql_server" "this" {
  name                         = var.name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  version                      = var.server_version
  minimum_tls_version          = var.minimum_tls_version

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Server firewall rules
resource "azurerm_mssql_firewall_rule" "this" {
  for_each = var.firewall_rules

  name             = each.key
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}

# Virtual network rule
resource "azurerm_mssql_virtual_network_rule" "this" {
  for_each = toset(var.virtual_network_subnet_ids)

  name      = "vnet-rule-${index(var.virtual_network_subnet_ids, each.value)}"
  server_id = azurerm_mssql_server.this.id
  subnet_id = each.value
}

# Server audit policy
resource "azurerm_mssql_server_audit_policy" "this" {
  count = var.enable_audit ? 1 : 0

  server_id              = azurerm_mssql_server.this.id
  enabled                = true
  storage_endpoint       = var.storage_account_id != null ? data.azurerm_storage_account.this[0].primary_blob_endpoint : null
  storage_account_access_key = var.storage_account_id != null ? data.azurerm_storage_account.this[0].primary_access_key : null
  storage_account_access_key_is_secondary = false
  retention_in_days      = var.audit_retention_days
}

data "azurerm_storage_account" "this" {
  count               = var.storage_account_id != null ? 1 : 0
  resource_group_name = var.resource_group_name
  name                = split("/", var.storage_account_id)[8]
}

# Private endpoint
resource "azurerm_private_endpoint" "this" {
  count               = var.create_private_endpoint ? 1 : 0
  name                = "${var.name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.name}-psc"
    private_connection_resource_id = azurerm_mssql_server.this.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  tags = var.tags
}

# Diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "this" {
  count                      = var.enable_diagnostics && var.log_analytics_workspace_id != null ? 1 : 0
  name                       = "${var.name}-diag"
  target_resource_id         = azurerm_mssql_server.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = ["SQLSecurityAuditEvents", "SQLInsights"]
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
