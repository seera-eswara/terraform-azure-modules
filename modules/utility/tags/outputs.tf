output "tags" {
  description = "Complete map of all tags (mandatory + optional + custom)"
  value       = local.all_tags
}

output "mandatory_tags" {
  description = "Map of mandatory tags only"
  value       = local.mandatory_tags
}

output "optional_tags" {
  description = "Map of optional tags only"
  value       = local.optional_tags
}
