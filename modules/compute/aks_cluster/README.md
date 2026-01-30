# Azure Kubernetes Service (AKS) Cluster Module

Deploys production-grade AKS clusters with security, networking, and monitoring features.

## Features

- Multiple node pool support
- Private cluster option
- System-assigned managed identity
- Azure CNI networking
- Network policies
- Pod security standards
- RBAC enabled
- Integration with Log Analytics
- Auto-scaling configuration
- Private endpoint support
- Diagnostic settings

## Usage

```hcl
module "aks_cluster" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/aks_cluster"

  name                = "mycluster"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  
  kubernetes_version = "1.27"
  
  # Networking
  network_plugin = "azure"
  service_cidr   = "10.0.0.0/16"
  dns_service_ip = "10.0.0.10"
  
  # Security
  private_cluster_enabled = true
  enable_pod_security_policy = false
  
  # Monitoring
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  
  # Node pool
  default_node_pool = {
    name            = "system"
    node_count      = 1
    vm_size         = "Standard_D2s_v3"
    max_surge       = "33%"
  }
}
```

## Outputs

- `id` - AKS cluster ID
- `kube_config` - Kube config for kubectl
- `kube_config_raw` - Raw kube config
- `identity_principal_id` - Managed identity principal ID
- `fqdn` - FQDN of the cluster
