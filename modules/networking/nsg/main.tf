# Azure Network Security Group
# Creates an NSG with flexible rule management and diagnostics

resource "azurerm_network_security_group" "nsg" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

# Security rules from variable
resource "azurerm_network_security_rule" "rules" {
  for_each = var.rules

  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  
  # Optional fields
  source_port_ranges           = try(each.value.source_port_ranges, null)
  destination_port_ranges      = try(each.value.destination_port_ranges, null)
  source_address_prefixes      = try(each.value.source_address_prefixes, null)
  destination_address_prefixes = try(each.value.destination_address_prefixes, null)
  source_application_security_group_ids = try(each.value.source_asg_ids, null)
  destination_application_security_group_ids = try(each.value.destination_asg_ids, null)

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# Diagnostic Settings for NSG
resource "azurerm_monitor_diagnostic_setting" "nsg_diagnostics" {
  count                      = var.log_analytics_workspace_id != "" ? 1 : 0
  name                       = "${var.name}-diagnostics"
  target_resource_id         = azurerm_network_security_group.nsg.id
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

# Flow logs for NSG (optional)
resource "azurerm_network_watcher_flow_log" "nsg_flow_logs" {
  count                      = var.enable_flow_logs ? 1 : 0
  name                       = "${var.name}-flow-logs"
  network_watcher_name        = var.network_watcher_name
  network_watcher_resource_group_name = var.network_watcher_resource_group_name
  network_security_group_id   = azurerm_network_security_group.nsg.id
  storage_account_id          = var.storage_account_id
  enabled                     = true
  version                     = var.flow_logs_version

  tags = var.tags
}
