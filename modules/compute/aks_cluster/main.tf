resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix != null ? var.dns_prefix : var.name
  kubernetes_version  = var.kubernetes_version

  node_resource_group = var.node_resource_group

  default_node_pool {
    name            = var.default_node_pool.name
    node_count      = var.default_node_pool.node_count
    vm_size         = var.default_node_pool.vm_size
    os_sku          = var.default_node_pool.os_sku
    availability_zones = var.default_node_pool.availability_zones
    max_surge       = var.default_node_pool.max_surge
    max_unavailable = var.default_node_pool.max_unavailable
    enable_auto_scaling = var.default_node_pool.enable_auto_scaling
    min_count       = var.default_node_pool.min_count
    max_count       = var.default_node_pool.max_count

    vnet_subnet_id = var.vnet_subnet_id

    upgrade_settings {
      drain_timeout_in_minutes      = var.default_node_pool.drain_timeout_in_minutes
      max_surge                     = var.default_node_pool.max_surge
      node_soak_duration_in_minutes = var.default_node_pool.node_soak_duration_in_minutes
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin      = var.network_plugin
    service_cidr        = var.service_cidr
    dns_service_ip      = var.dns_service_ip
    load_balancer_sku   = var.load_balancer_sku
    network_policy      = var.network_policy
    docker_bridge_cidr  = var.docker_bridge_cidr
    outbound_type       = var.outbound_type
  }

  api_server_access_profile {
    authorized_ip_ranges     = var.api_server_authorized_ip_ranges
    subnet_id               = var.api_server_subnet_id
  }

  role_based_access_control_enabled = var.enable_rbac
  azure_policy_enabled              = var.enable_azure_policy

  private_cluster_enabled      = var.private_cluster_enabled
  private_dns_zone_id          = var.private_dns_zone_id

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  azure_active_directory_role_based_access_control {
    managed                   = var.enable_aad_rbac
    admin_group_object_ids    = var.admin_group_object_ids
  }

  tags = var.tags
}

# Diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "this" {
  count                      = var.enable_diagnostics && var.log_analytics_workspace_id != null ? 1 : 0
  name                       = "${var.name}-diag"
  target_resource_id         = azurerm_kubernetes_cluster.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = ["kube-apiserver", "kube-controller-manager", "kube-scheduler", "kube-audit"]
    content {
      category = enabled_log.value
      enabled  = true
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

# Additional node pools
resource "azurerm_kubernetes_cluster_node_pool" "this" {
  for_each = var.additional_node_pools

  name                  = each.key
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
  os_sku                = each.value.os_sku
  availability_zones    = each.value.availability_zones
  max_surge             = each.value.max_surge
  max_unavailable       = each.value.max_unavailable
  enable_auto_scaling   = each.value.enable_auto_scaling
  min_count             = each.value.min_count
  max_count             = each.value.max_count
  vnet_subnet_id        = each.value.vnet_subnet_id != null ? each.value.vnet_subnet_id : var.vnet_subnet_id
  labels                = each.value.labels
  taints                = each.value.taints

  tags = var.tags
}
