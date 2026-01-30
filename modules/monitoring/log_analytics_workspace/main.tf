# Azure Log Analytics Workspace
# Creates a workspace for monitoring, logging, and analytics

resource "azurerm_log_analytics_workspace" "workspace" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  retention_in_days   = var.retention_days

  # Daily quota in GB (0 = unlimited)
  daily_quota_gb = var.daily_quota_gb

  # Internet ingestion and query settings
  internet_ingestion_enabled = var.internet_ingestion_enabled
  internet_query_enabled     = var.internet_query_enabled

  # CMK encryption (requires key vault)
  dynamic "cmk_for_query_forced" {
    for_each = var.cmk_enabled ? [1] : []
    content {
      value = true
    }
  }

  tags = var.tags
}

# Solutions for the workspace (optional)
resource "azurerm_log_analytics_solution" "solutions" {
  for_each = toset(var.solutions)

  solution_name         = each.value
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_name        = azurerm_log_analytics_workspace.workspace.name
  workspace_resource_id = azurerm_log_analytics_workspace.workspace.id

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/${each.value}"
  }
}

# Saved searches (optional)
resource "azurerm_log_analytics_saved_search" "saved_searches" {
  for_each = var.saved_searches

  name                = each.key
  log_analytics_workspace_id = azurerm_log_analytics_workspace.workspace.id
  log_analytics_workspace_name = azurerm_log_analytics_workspace.workspace.name
  resource_group_name = var.resource_group_name

  query   = each.value.query
  display_name = each.value.display_name
  category = try(each.value.category, "General")
}
