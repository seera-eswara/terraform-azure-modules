output "id" {
  description = "The ID of the Action Group"
  value       = azurerm_monitor_action_group.ag.id
}

output "name" {
  description = "The name of the Action Group"
  value       = azurerm_monitor_action_group.ag.name
}
