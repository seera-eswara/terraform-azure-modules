output "id" {
  description = "The ID of the diagnostic setting"
  value       = azurerm_monitor_diagnostic_setting.diagnostics.id
}

output "name" {
  description = "The name of the diagnostic setting"
  value       = azurerm_monitor_diagnostic_setting.diagnostics.name
}
