output "id" {
  description = "VM ID"
  value       = azurerm_linux_virtual_machine.this.id
}

output "name" {
  description = "VM name"
  value       = azurerm_linux_virtual_machine.this.name
}

output "private_ip_address" {
  description = "Private IP address"
  value       = azurerm_network_interface.this.private_ip_address
}

output "identity_principal_id" {
  description = "Managed identity principal ID"
  value       = azurerm_linux_virtual_machine.this.identity[0].principal_id
}

output "network_interface_id" {
  description = "Network interface ID"
  value       = azurerm_network_interface.this.id
}
