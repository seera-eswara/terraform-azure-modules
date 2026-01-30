output "id" {
  description = "Container App ID"
  value       = azurerm_container_app.this.id
}

output "fqdn" {
  description = "FQDN of the Container App"
  value       = try(azurerm_container_app.this.ingress[0].fqdn, null)
}

output "identity_principal_id" {
  description = "Managed identity principal ID"
  value       = try(azurerm_container_app.this.identity[0].principal_id, null)
}
