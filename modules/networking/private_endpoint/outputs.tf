output "id" {
  description = "The ID of the private endpoint"
  value       = azurerm_private_endpoint.pe.id
}

output "name" {
  description = "The name of the private endpoint"
  value       = azurerm_private_endpoint.pe.name
}

output "network_interface_ids" {
  description = "The network interface IDs associated with the private endpoint"
  value       = azurerm_private_endpoint.pe.network_interface_ids
}

output "private_ip_address" {
  description = "The private IP address"
  value       = length(data.azurerm_network_interface.pe_nic) > 0 ? data.azurerm_network_interface.pe_nic[0].private_ip_address : ""
}

output "private_ip_addresses" {
  description = "The private IP addresses"
  value       = length(data.azurerm_network_interface.pe_nic) > 0 ? data.azurerm_network_interface.pe_nic[0].private_ip_addresses : []
}
