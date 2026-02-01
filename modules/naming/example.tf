# Example: Using the naming module in app1-infra
# COMMENTED OUT TO PREVENT CIRCULAR DEPENDENCY DURING TERRAFORM INIT
# This file is for reference only and should not be processed by Terraform

# module "naming" {
#   source = "git::https://github.com/seera-eswara/terraform-azure-modules.git//modules/naming?ref=main"
# 
#   app_code    = "app"  # 3-letter code for app1
#   environment = "dev"
#   location    = "eastus"
#   instance    = 1
# 
#   additional_tags = {
#     Team       = "app-team-1"
#     CostCenter = "CC-1001"
#     Owner      = "app1-team@company.com"
#   }
# }
# 
# # Use generated names consistently
# resource "azurerm_resource_group" "app" {
#   name     = module.naming.names.resource_group  # rg-app-dev-eus-01
#   location = "eastus"
#   tags     = module.naming.tags
# }
# 
# resource "azurerm_log_analytics_workspace" "this" {
#   name                = module.naming.names.log_analytics_workspace  # law-app-dev-eus-01
#   location            = "eastus"
#   resource_group_name = azurerm_resource_group.app.name
#   sku                 = "PerGB2018"
#   retention_in_days   = 30
#   tags                = module.naming.tags
# }
# 
# module "aks" {
#   source = "git::https://github.com/seera-eswara/terraform-azure-modules.git//modules/aks?ref=f94383044a37da515aa0557225aa00825f96ccf4"
# 
#   name           = module.naming.names.aks_cluster  # aks-app-dev-eus-01
#   location       = "eastus"
#   resource_group = azurerm_resource_group.app.name
# 
#   vm_size    = "Standard_D4s_v3"
#   node_count = 2
# 
#   enable_oms_agent           = true
#   log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
# 
#   tags = module.naming.tags
# }
# 
# # Example: Multiple resources with consistent naming
# resource "azurerm_virtual_network" "this" {
#   name                = module.naming.names.virtual_network  # vnet-app-dev-eus-01
#   location            = "eastus"
#   resource_group_name = azurerm_resource_group.app.name
#   address_space       = ["10.0.0.0/16"]
#   tags                = module.naming.tags
# }
# 
# resource "azurerm_key_vault" "this" {
#   name                = module.naming.names.key_vault  # kv-app-dev-eus-01
#   location            = "eastus"
#   resource_group_name = azurerm_resource_group.app.name
#   tenant_id           = data.azurerm_client_config.current.tenant_id
#   sku_name            = "standard"
#   tags                = module.naming.tags
# }
