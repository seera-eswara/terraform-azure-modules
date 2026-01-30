output "id" {
  description = "The ID of the Cosmos DB account"
  value       = azurerm_cosmosdb_account.cosmos.id
}

output "endpoint" {
  description = "The endpoint used to connect to Cosmos DB"
  value       = azurerm_cosmosdb_account.cosmos.endpoint
}

output "primary_key" {
  description = "The primary master key for authentication"
  value       = azurerm_cosmosdb_account.cosmos.primary_key
  sensitive   = true
}

output "primary_readonly_key" {
  description = "The primary read-only key"
  value       = azurerm_cosmosdb_account.cosmos.primary_readonly_key
  sensitive   = true
}

output "secondary_key" {
  description = "The secondary master key for authentication"
  value       = azurerm_cosmosdb_account.cosmos.secondary_key
  sensitive   = true
}

output "secondary_readonly_key" {
  description = "The secondary read-only key"
  value       = azurerm_cosmosdb_account.cosmos.secondary_readonly_key
  sensitive   = true
}

output "principal_id" {
  description = "The principal ID of the system assigned managed identity"
  value       = azurerm_cosmosdb_account.cosmos.identity[0].principal_id
}
