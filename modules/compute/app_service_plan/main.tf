resource "azurerm_app_service_plan" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = var.os_type == "Linux" ? "Linux" : var.kind
  reserved            = var.os_type == "Linux" ? true : var.reserved

  sku {
    tier = var.sku_tier
    size = var.sku_size
  }

  per_site_scaling = var.per_site_scaling
  zone_redundant   = var.zone_redundant

  tags = var.tags
}

# Diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "this" {
  count                      = var.enable_diagnostics && var.log_analytics_workspace_id != null ? 1 : 0
  name                       = "${var.name}-diag"
  target_resource_id         = azurerm_app_service_plan.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
