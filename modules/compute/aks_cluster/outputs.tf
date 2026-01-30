output "id" {
  description = "AKS cluster ID"
  value       = azurerm_kubernetes_cluster.this.id
}

output "fqdn" {
  description = "Fully qualified domain name of the cluster"
  value       = azurerm_kubernetes_cluster.this.fqdn
}

output "private_fqdn" {
  description = "Private FQDN of the cluster"
  value       = try(azurerm_kubernetes_cluster.this.private_fqdn, null)
}

output "kube_config" {
  description = "Kube config"
  value       = azurerm_kubernetes_cluster.this.kube_config
  sensitive   = true
}

output "kube_config_raw" {
  description = "Raw kube config"
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}

output "identity_principal_id" {
  description = "Managed identity principal ID"
  value       = azurerm_kubernetes_cluster.this.identity[0].principal_id
}

output "kubelet_identity" {
  description = "Kubelet identity"
  value       = try(azurerm_kubernetes_cluster.this.kubelet_identity, null)
}
