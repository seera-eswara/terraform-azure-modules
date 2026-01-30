# Azure Role Assignment
# Creates an RBAC role assignment for a principal at a specified scope

resource "azurerm_role_assignment" "assignment" {
  scope              = var.scope
  principal_id       = var.principal_id
  role_definition_id = var.role_definition_id != "" ? var.role_definition_id : null
  role_definition_name = var.role_definition_name != "" ? var.role_definition_name : null
}

# Validate that either role_definition_name or role_definition_id is provided
locals {
  validate_role = var.role_definition_name == "" && var.role_definition_id == "" ? (
    file("ERROR: Either role_definition_name or role_definition_id must be provided")
  ) : null
}
