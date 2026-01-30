output "id" {
  description = "SQL Server ID"
  value       = azurerm_mssql_server.this.id
}

output "fqdn" {
  description = "Fully qualified domain name"
  value       = azurerm_mssql_server.this.fully_qualified_domain_name
}

output "identity_principal_id" {
  description = "Managed identity principal ID"
  value       = azurerm_mssql_server.this.identity[0].principal_id
}

output "private_endpoint_id" {
  description = "Private endpoint ID"
  value       = try(azurerm_private_endpoint.this[0].id, null)
}
