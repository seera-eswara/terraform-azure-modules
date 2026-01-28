output "names" {
  description = "Map of resource type to standardized name"
  value       = local.names
}

output "tags" {
  description = "Standard tags to apply to all resources"
  value       = local.tags
}

output "subscription" {
  description = "Subscription name following pattern: {app}-{module}-{env}"
  value       = local.names.subscription
}

output "management_group" {
  description = "Management group name: mg-{app}"
  value       = local.names.management_group
}

output "resource_group" {
  description = "Resource group name"
  value       = local.names.resource_group
}

output "aks_cluster" {
  description = "AKS cluster name"
  value       = local.names.aks_cluster
}

output "log_analytics_workspace" {
  description = "Log Analytics workspace name"
  value       = local.names.log_analytics_workspace
}

output "key_vault" {
  description = "Key Vault name"
  value       = local.names.key_vault
}

output "storage_account" {
  description = "Storage account name (lowercase, no hyphens)"
  value       = local.names.storage_account
}

output "virtual_network" {
  description = "Virtual network name"
  value       = local.names.virtual_network
}
