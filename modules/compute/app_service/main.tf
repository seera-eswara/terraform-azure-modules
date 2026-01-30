terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.57.0"
    }
  }
}

data "azurerm_client_config" "current" {}

# Create App Service
resource "azurerm_app_service" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.app_service_plan_id

  https_only = true
  client_affinity_enabled = false

  site_config {
    linux_fx_version = var.os_type == "Linux" ? "DOCKER|mcr.microsoft.com/azure-app-service/windows/servercore:ltsc2019" : null
    always_on        = true
    min_tls_version  = "1.2"
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = merge(
    var.app_settings,
    var.enable_diagnostics ? {
      "APPINSIGHTS_INSTRUMENTATIONKEY" = var.log_analytics_workspace_id != null ? "placeholder" : ""
    } : {}
  )

  dynamic "connection_string" {
    for_each = var.connection_strings != null ? var.connection_strings : {}
    content {
      name  = connection_string.key
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [app_settings["APPINSIGHTS_INSTRUMENTATIONKEY"]]
  }

  depends_on = [var.app_service_plan_id]
}

# Network configuration for App Service
resource "azurerm_app_service_virtual_network_swift_connection" "this" {
  count              = var.vnet_integration_subnet_id != null ? 1 : 0
  app_service_id     = azurerm_app_service.this.id
  subnet_id          = var.vnet_integration_subnet_id
}

# Private endpoint for App Service
resource "azurerm_private_endpoint" "this" {
  count               = var.create_private_endpoint ? 1 : 0
  name                = "${var.name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.name}-psc"
    private_connection_resource_id = azurerm_app_service.this.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  tags = var.tags
}

# Diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "this" {
  count                      = var.enable_diagnostics && var.log_analytics_workspace_id != null ? 1 : 0
  name                       = "${var.name}-diag"
  target_resource_id         = azurerm_app_service.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = ["AppServiceHTTPLogs", "AppServiceConsoleLogs", "AppServiceAppLogs", "AppServiceIPSecAuditLogs", "AppServicePlatformLogs"]
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
