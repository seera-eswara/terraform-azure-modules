output "id" {
  description = "The ID of the private DNS zone link"
  value       = azurerm_private_dns_zone_virtual_network_link.link.id
}

output "name" {
  description = "The name of the private DNS zone link"
  value       = azurerm_private_dns_zone_virtual_network_link.link.name
}

output "virtual_network_id" {
  description = "The virtual network ID"
  value       = azurerm_private_dns_zone_virtual_network_link.link.virtual_network_id
}
