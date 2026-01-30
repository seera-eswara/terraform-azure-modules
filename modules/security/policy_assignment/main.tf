# Azure Management Group Policy Assignment
# Assigns a policy to a management group for governance

resource "azurerm_management_group_policy_assignment" "assignment" {
  name                 = var.name
  policy_definition_id = var.policy_definition_id
  management_group_id  = var.management_group_id
  enforce              = var.enforcement_mode == "Default" ? true : false

  # Optional: Identity for remediation tasks
  dynamic "identity" {
    for_each = var.identity_type != "" ? [1] : []
    content {
      type = var.identity_type
    }
  }

  # Optional: Parameters for policy
  dynamic "parameters" {
    for_each = var.parameters != {} ? [1] : []
    content {
      value = jsonencode(var.parameters)
    }
  }

  # Description
  description = var.description

  # Display name
  display_name = var.display_name
}

# Remediation task (optional) for non-compliant resources
resource "azurerm_management_group_policy_remediation" "remediation" {
  count              = var.create_remediation_task ? 1 : 0
  name               = "${var.name}-remediation"
  management_group_id = var.management_group_id
  policy_assignment_id = azurerm_management_group_policy_assignment.assignment.id
}
