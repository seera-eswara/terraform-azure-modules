variable "name" {
  description = "AKS cluster name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = null  # Use latest
}

variable "dns_prefix" {
  description = "DNS prefix for the cluster"
  type        = string
  default     = null
}

variable "node_resource_group" {
  description = "Name of the resource group for nodes"
  type        = string
  default     = null
}

variable "vnet_subnet_id" {
  description = "Subnet ID for nodes"
  type        = string
  default     = null
}

variable "default_node_pool" {
  description = "Default node pool configuration"
  type = object({
    name                          = string
    node_count                    = number
    vm_size                       = string
    os_sku                        = optional(string, "Ubuntu")
    availability_zones            = optional(list(string), [])
    max_surge                     = optional(string, "33%")
    max_unavailable               = optional(string, "0")
    enable_auto_scaling           = optional(bool, true)
    min_count                     = optional(number, 1)
    max_count                     = optional(number, 10)
    drain_timeout_in_minutes      = optional(number, 0)
    node_soak_duration_in_minutes = optional(number, 0)
  })
  default = {
    name       = "system"
    node_count = 1
    vm_size    = "Standard_D2s_v3"
  }
}

variable "network_plugin" {
  description = "Network plugin (azure or kubenet)"
  type        = string
  default     = "azure"
}

variable "service_cidr" {
  description = "Service CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "dns_service_ip" {
  description = "DNS service IP"
  type        = string
  default     = "10.0.0.10"
}

variable "docker_bridge_cidr" {
  description = "Docker bridge CIDR"
  type        = string
  default     = "172.17.0.1/16"
}

variable "load_balancer_sku" {
  description = "Load balancer SKU (basic or standard)"
  type        = string
  default     = "standard"
}

variable "network_policy" {
  description = "Network policy (azure or calico)"
  type        = string
  default     = "azure"
}

variable "outbound_type" {
  description = "Outbound type (loadBalancer, userDefinedRouting)"
  type        = string
  default     = "loadBalancer"
}

variable "api_server_authorized_ip_ranges" {
  description = "API server authorized IP ranges"
  type        = list(string)
  default     = []
}

variable "api_server_subnet_id" {
  description = "API server subnet ID"
  type        = string
  default     = null
}

variable "enable_rbac" {
  description = "Enable RBAC"
  type        = bool
  default     = true
}

variable "enable_azure_policy" {
  description = "Enable Azure Policy"
  type        = bool
  default     = true
}

variable "private_cluster_enabled" {
  description = "Enable private cluster"
  type        = bool
  default     = true
}

variable "private_dns_zone_id" {
  description = "Private DNS zone ID"
  type        = string
  default     = null
}

variable "enable_aad_rbac" {
  description = "Enable Azure AD RBAC"
  type        = bool
  default     = true
}

variable "admin_group_object_ids" {
  description = "Admin group object IDs"
  type        = list(string)
  default     = []
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace ID"
  type        = string
  default     = null
}

variable "enable_diagnostics" {
  description = "Enable diagnostic settings"
  type        = bool
  default     = true
}

variable "additional_node_pools" {
  description = "Additional node pools"
  type = map(object({
    vm_size             = string
    node_count          = number
    os_sku              = optional(string, "Ubuntu")
    availability_zones  = optional(list(string), [])
    max_surge           = optional(string, "33%")
    max_unavailable     = optional(string, "0")
    enable_auto_scaling = optional(bool, true)
    min_count           = optional(number, 1)
    max_count           = optional(number, 10)
    vnet_subnet_id      = optional(string, null)
    labels              = optional(map(string), {})
    taints              = optional(list(map(string)), [])
  }))
  default = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
