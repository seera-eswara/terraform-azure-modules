output "id" {
  description = "The ID of the managed identity"
  value       = azurerm_user_assigned_identity.identity.id
}

output "principal_id" {
  description = "The principal ID of the managed identity (for RBAC assignments)"
  value       = azurerm_user_assigned_identity.identity.principal_id
}

output "client_id" {
  description = "The client ID of the managed identity"
  value       = azurerm_user_assigned_identity.identity.client_id
}

output "tenant_id" {
  description = "The tenant ID of the managed identity"
  value       = azurerm_user_assigned_identity.identity.tenant_id
}
