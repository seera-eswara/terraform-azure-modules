output "id" {
  description = "App Service Plan ID"
  value       = azurerm_app_service_plan.this.id
}

output "name" {
  description = "App Service Plan name"
  value       = azurerm_app_service_plan.this.name
}

output "maximum_worker_count" {
  description = "Maximum number of workers"
  value       = azurerm_app_service_plan.this.maximum_elastic_worker_count
}
