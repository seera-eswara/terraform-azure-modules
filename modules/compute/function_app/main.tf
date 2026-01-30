resource "azurerm_function_app" "this" {
  name                       = var.name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = var.app_service_plan_id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  https_only                 = true

  app_settings = merge(
    var.app_settings,
    {
      "FUNCTIONS_WORKER_RUNTIME"       = var.runtime_name
      "WEBSITE_RUN_FROM_PACKAGE"       = "1"
      "WEBSITE_ENABLE_SYNC_UPDATE_SITE" = "true"
    }
  )

  dynamic "connection_string" {
    for_each = var.connection_strings != null ? var.connection_strings : {}
    content {
      name  = connection_string.key
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

  depends_on = [var.app_service_plan_id]
}

# VNet integration
resource "azurerm_function_app_virtual_network_swift_connection" "this" {
  count              = var.vnet_integration_subnet_id != null ? 1 : 0
  function_app_id    = azurerm_function_app.this.id
  subnet_id          = var.vnet_integration_subnet_id
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
    private_connection_resource_id = azurerm_function_app.this.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  tags = var.tags
}

# Diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "this" {
  count                      = var.enable_diagnostics && var.log_analytics_workspace_id != null ? 1 : 0
  name                       = "${var.name}-diag"
  target_resource_id         = azurerm_function_app.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = ["FunctionAppLogs", "AppServiceHTTPLogs", "AppServiceConsoleLogs"]
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
