output "id" {
  description = "Storage account ID"
  value       = azurerm_storage_account.this.id
}

output "name" {
  description = "Storage account name"
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "Primary blob endpoint"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "primary_access_key" {
  description = "Primary access key"
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
}

output "identity_principal_id" {
  description = "Managed identity principal ID"
  value       = azurerm_storage_account.this.identity[0].principal_id
}

output "private_endpoint_id" {
  description = "Private endpoint ID"
  value       = try(azurerm_private_endpoint.blob[0].id, null)
}
