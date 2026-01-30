output "id" {
  description = "The ID of the Network Security Group"
  value       = azurerm_network_security_group.nsg.id
}

output "name" {
  description = "The name of the Network Security Group"
  value       = azurerm_network_security_group.nsg.name
}

output "resource_group_name" {
  description = "The resource group name"
  value       = azurerm_network_security_group.nsg.resource_group_name
}
