output "id" {
  description = "The ID of the policy assignment"
  value       = azurerm_management_group_policy_assignment.assignment.id
}

output "name" {
  description = "The name of the policy assignment"
  value       = azurerm_management_group_policy_assignment.assignment.name
}

output "management_group_id" {
  description = "The management group ID"
  value       = azurerm_management_group_policy_assignment.assignment.management_group_id
}
