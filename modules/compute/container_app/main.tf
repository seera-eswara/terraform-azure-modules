resource "azurerm_container_app" "this" {
  name                         = var.name
  container_app_environment_id = var.container_app_environment_id
  resource_group_name          = var.resource_group_name
  revision_mode                = var.revision_mode

  dynamic "identity" {
    for_each = var.enable_identity ? [1] : []
    content {
      type = "SystemAssigned"
    }
  }

  template {
    dynamic "container" {
      for_each = var.containers
      content {
        name   = container.value.name
        image  = container.value.image
        cpu    = container.value.cpu
        memory = container.value.memory

        dynamic "env" {
          for_each = container.value.env != null ? container.value.env : {}
          content {
            name  = env.key
            value = env.value
          }
        }

        dynamic "env" {
          for_each = container.value.secrets != null ? container.value.secrets : {}
          content {
            name        = env.key
            secret_name = env.value
          }
        }

        dynamic "port" {
          for_each = container.value.port != null ? [container.value.port] : []
          content {
            container_port = port.value
          }
        }
      }
    }

    min_replicas = var.min_replicas
    max_replicas = var.max_replicas
  }

  dynamic "ingress" {
    for_each = var.enable_ingress ? [1] : []
    content {
      allow_insecure_connections = false
      external_enabled           = var.external_enabled
      target_port                = var.target_port
      traffic_weight {
        percentage      = 100
        latest_revision = true
      }
    }
  }

  dynamic "secret" {
    for_each = var.secrets != null ? var.secrets : {}
    content {
      name  = secret.key
      value = secret.value
    }
  }

  tags = var.tags
}

# Diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "this" {
  count                      = var.enable_diagnostics && var.log_analytics_workspace_id != null ? 1 : 0
  name                       = "${var.name}-diag"
  target_resource_id         = azurerm_container_app.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
