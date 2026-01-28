output "management_group_id" {
  description = "ID of the created app management group"
  value       = azurerm_management_group.app.id
}

output "management_group_name" {
  description = "Name of the created app management group"
  value       = azurerm_management_group.app.name
}

output "management_group_display_name" {
  description = "Display name of the created app management group"
  value       = azurerm_management_group.app.display_name
}
