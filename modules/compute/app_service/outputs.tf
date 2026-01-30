output "id" {
  description = "App Service ID"
  value       = azurerm_app_service.this.id
}

output "name" {
  description = "App Service name"
  value       = azurerm_app_service.this.name
}

output "default_hostname" {
  description = "Default hostname"
  value       = azurerm_app_service.this.default_site_hostname
}

output "identity_principal_id" {
  description = "Managed identity principal ID"
  value       = azurerm_app_service.this.identity[0].principal_id
}

output "outbound_ip_addresses" {
  description = "Outbound IP addresses"
  value       = split(",", azurerm_app_service.this.outbound_ip_addresses)
}

output "possible_outbound_ip_addresses" {
  description = "Possible outbound IP addresses"
  value       = split(",", azurerm_app_service.this.possible_outbound_ip_addresses)
}

output "private_endpoint_id" {
  description = "Private endpoint ID"
  value       = try(azurerm_private_endpoint.this[0].id, null)
}
