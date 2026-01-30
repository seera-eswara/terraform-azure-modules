# Azure Service Bus Namespace
# Creates a service bus namespace for messaging and event processing

resource "azurerm_servicebus_namespace" "sb_ns" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  capacity            = var.sku == "Premium" ? var.capacity : null

  # Enable managed identity
  identity {
    type = "SystemAssigned"
  }

  # Local authentication disabled for security (use managed identity or AAD)
  local_auth_enabled = var.enable_local_auth

  # Network settings
  network_rulesets {
    default_action                 = "Deny"
    public_network_access_enabled  = var.enable_public_network_access
    
    # Trusted Microsoft services
    trusted_service_access_enabled = true

    dynamic "virtual_network_rule" {
      for_each = var.virtual_network_rule_ids
      content {
        subnet_id = virtual_network_rule.value
      }
    }

    dynamic "ip_rule" {
      for_each = var.allowed_ip_addresses
      content {
        ip_mask = ip_rule.value
      }
    }
  }

  # Premium features
  premium_messaging_partitions = var.sku == "Premium" ? var.premium_messaging_partitions : null

  tags = var.tags
}

# Private Endpoint for Service Bus (if enabled)
resource "azurerm_private_endpoint" "sb_pe" {
  count               = var.create_private_endpoint ? 1 : 0
  name                = "${var.name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.name}-psc"
    private_connection_resource_id = azurerm_servicebus_namespace.sb_ns.id
    subresource_names              = ["namespace"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "${var.name}-dns"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  tags = var.tags
}

# Authorization rule for namespace
resource "azurerm_servicebus_namespace_authorization_rule" "default" {
  name                = "${var.name}-auth"
  namespace_id        = azurerm_servicebus_namespace.sb_ns.id

  listen = true
  send   = true
  manage = false
}

# Diagnostic Settings for Service Bus Namespace
resource "azurerm_monitor_diagnostic_setting" "sb_diagnostics" {
  count                      = var.log_analytics_workspace_id != "" ? 1 : 0
  name                       = "${var.name}-diagnostics"
  target_resource_id         = azurerm_servicebus_namespace.sb_ns.id
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
