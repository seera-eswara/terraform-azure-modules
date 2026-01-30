output "id" {
  description = "The ID of the Event Hub namespace"
  value       = azurerm_eventhub_namespace.eh_ns.id
}

output "name" {
  description = "The name of the Event Hub namespace"
  value       = azurerm_eventhub_namespace.eh_ns.name
}

output "connection_string" {
  description = "The connection string for the Event Hub namespace"
  value       = azurerm_eventhub_namespace_authorization_rule.default.primary_connection_string
  sensitive   = true
}

output "primary_connection_string" {
  description = "The primary connection string"
  value       = azurerm_eventhub_namespace_authorization_rule.default.primary_connection_string
  sensitive   = true
}

output "secondary_connection_string" {
  description = "The secondary connection string"
  value       = azurerm_eventhub_namespace_authorization_rule.default.secondary_connection_string
  sensitive   = true
}

output "principal_id" {
  description = "The principal ID of the system assigned managed identity"
  value       = azurerm_eventhub_namespace.eh_ns.identity[0].principal_id
}
