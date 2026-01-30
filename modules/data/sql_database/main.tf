# Azure SQL Database Resource
# Creates a managed SQL database with diagnostic settings

resource "azurerm_mssql_database" "sql_db" {
  name                 = var.database_name
  server_id            = var.server_id
  collation            = var.collation
  sku_name             = var.sku_name
  
  # Backup configuration
  point_in_time_restore_days = var.backup_retention_days
  
  # Threat detection configuration
  threat_detection_policy {
    state              = "Enabled"
    disabled_alerts    = []
    email_addresses    = var.threat_detection_emails
    retention_days     = 30
  }
  
  tags = var.tags
}

# Diagnostic Settings for SQL Database
resource "azurerm_monitor_diagnostic_setting" "sql_db_diagnostics" {
  count                      = var.log_analytics_workspace_id != "" ? 1 : 0
  name                       = "${var.database_name}-diagnostics"
  target_resource_id         = azurerm_mssql_database.sql_db.id
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

# SQL Database Vulnerability Assessment
resource "azurerm_mssql_database_vulnerability_assessment_rule_baseline" "sql_db_va" {
  database_name                = azurerm_mssql_database.sql_db.name
  server_name                  = data.azurerm_mssql_server.sql_server.name
  resource_group_name          = data.azurerm_mssql_server.sql_server.resource_group_name
  rule_id                      = "VA2014"
  baseline_rule_enabled        = true
}

# Data source to get server information
data "azurerm_mssql_server" "sql_server" {
  name                = split("/", var.server_id)[8]
  resource_group_name = split("/", var.server_id)[4]
}
