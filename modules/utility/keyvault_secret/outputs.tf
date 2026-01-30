output "id" {
  description = "The ID of the Key Vault secret (including version)"
  value       = azurerm_key_vault_secret.this.id
}

output "version" {
  description = "The current version of the Key Vault secret"
  value       = azurerm_key_vault_secret.this.version
}

output "versionless_id" {
  description = "The versionless ID of the Key Vault secret"
  value       = azurerm_key_vault_secret.this.versionless_id
}
