output "id" {
  description = "The ID of the storage container"
  value       = azurerm_storage_container.this.id
}

output "name" {
  description = "The name of the storage container"
  value       = azurerm_storage_container.this.name
}

output "resource_manager_id" {
  description = "The Resource Manager ID of the storage container"
  value       = azurerm_storage_container.this.resource_manager_id
}
