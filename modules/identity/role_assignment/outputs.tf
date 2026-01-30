output "id" {
  description = "The ID of the role assignment"
  value       = azurerm_role_assignment.assignment.id
}

output "principal_id" {
  description = "The principal ID"
  value       = azurerm_role_assignment.assignment.principal_id
}

output "scope" {
  description = "The scope of the role assignment"
  value       = azurerm_role_assignment.assignment.scope
}

output "role_definition_id" {
  description = "The role definition ID"
  value       = azurerm_role_assignment.assignment.role_definition_id
}
