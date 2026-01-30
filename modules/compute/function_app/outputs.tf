output "id" {
  description = "Function App ID"
  value       = azurerm_function_app.this.id
}

output "default_hostname" {
  description = "Default hostname"
  value       = azurerm_function_app.this.default_hostname
}

output "identity_principal_id" {
  description = "Managed identity principal ID"
  value       = azurerm_function_app.this.identity[0].principal_id
}

output "private_endpoint_id" {
  description = "Private endpoint ID"
  value       = try(azurerm_private_endpoint.this[0].id, null)
}
