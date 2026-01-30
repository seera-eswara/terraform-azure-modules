locals {
  # Mandatory tags
  mandatory_tags = {
    Environment = var.environment
    Application = var.application
    CostCenter  = var.cost_center
    ManagedBy   = var.managed_by
    CreatedDate = formatdate("YYYY-MM-DD", timestamp())
  }

  # Optional tags (only include if provided)
  optional_tags = merge(
    var.project != null ? { Project = var.project } : {},
    var.owner != null ? { Owner = var.owner } : {},
    var.business_unit != null ? { BusinessUnit = var.business_unit } : {},
    var.data_classification != null ? { DataClassification = var.data_classification } : {},
    var.compliance != null ? { Compliance = var.compliance } : {},
    var.disaster_recovery != null ? { DisasterRecovery = var.disaster_recovery } : {}
  )

  # Merge all tags
  all_tags = merge(
    local.mandatory_tags,
    local.optional_tags,
    var.custom_tags
  )
}
