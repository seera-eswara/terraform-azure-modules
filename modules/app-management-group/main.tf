# App Management Group Module
# Creates a management group for each application with naming pattern: MG-{APP_CODE}
# This allows for app team isolation and policy inheritance
# 
# Used by terraform-azure-subscription-factory to create app-specific management groups
# as part of the subscription provisioning process.

resource "azurerm_management_group" "app" {
  name                       = "mg-${lower(var.app_code)}"
  display_name               = "MG-${upper(var.app_code)}"
  parent_management_group_id = var.parent_management_group_id
}

# Assign owners to the app MG
resource "azurerm_role_assignment" "app_owners" {
  for_each = toset(var.app_owners)

  scope                = azurerm_management_group.app.id
  role_definition_name = "Management Group Contributor"
  principal_id         = each.value
}

# Assign contributors to the app MG
resource "azurerm_role_assignment" "app_contributors" {
  for_each = toset(var.app_contributors)

  scope                = azurerm_management_group.app.id
  role_definition_name = "Contributor"
  principal_id         = each.value
}
