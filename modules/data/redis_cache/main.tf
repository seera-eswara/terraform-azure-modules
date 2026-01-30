# Azure Cache for Redis
# Creates a managed Redis cache with security and monitoring features

resource "azurerm_redis_cache" "redis" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = var.capacity
  family              = var.family
  sku_name            = var.sku_name
  
  # Enable SSL/TLS only
  ssl_enabled = true

  # Firewall configuration
  minimum_tls_version = var.minimum_tls_version
  enable_non_ssl_port = false

  # Shard count for cluster mode (Premium only)
  shard_count = var.family == "P" ? var.shard_count : null

  # Zones (Premium only)
  zones = var.family == "P" ? var.zones : null

  # Replicas (Premium only)
  replicas_per_master = var.family == "P" ? var.replicas_per_master : null

  # Public network access
  public_network_access_enabled = var.enable_public_network_access

  # Firewall rules
  dynamic "redis_configuration" {
    for_each = var.redis_configuration != null ? [var.redis_configuration] : []
    content {
      aof_backup_enabled              = redis_configuration.value.aof_backup_enabled
      aof_storage_connection_string_0 = redis_configuration.value.aof_storage_connection_string_0
      aof_storage_connection_string_1 = redis_configuration.value.aof_storage_connection_string_1
      enable_authentication            = redis_configuration.value.enable_authentication
      maxmemory_policy                = redis_configuration.value.maxmemory_policy
      maxmemory_reserved              = redis_configuration.value.maxmemory_reserved
      maxmemory_delta                 = redis_configuration.value.maxmemory_delta
      notify_keyspace_events         = redis_configuration.value.notify_keyspace_events
    }
  }

  tags = var.tags
}

# Private Endpoint for Redis (if enabled)
resource "azurerm_private_endpoint" "redis_pe" {
  count               = var.create_private_endpoint ? 1 : 0
  name                = "${var.name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id

  private_service_connection {
    name                           = "${var.name}-psc"
    private_connection_resource_id = azurerm_redis_cache.redis.id
    subresource_names              = ["redisCache"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "${var.name}-dns"
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  tags = var.tags
}

# Firewall rule for specific IP address
resource "azurerm_redis_firewall_rule" "rules" {
  for_each = var.firewall_rules

  name                = each.key
  redis_cache_name    = azurerm_redis_cache.redis.name
  resource_group_name = var.resource_group_name
  start_ip            = each.value.start_ip
  end_ip              = each.value.end_ip
}

# Diagnostic Settings for Redis
resource "azurerm_monitor_diagnostic_setting" "redis_diagnostics" {
  count                      = var.log_analytics_workspace_id != "" ? 1 : 0
  name                       = "${var.name}-diagnostics"
  target_resource_id         = azurerm_redis_cache.redis.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  # Enabled logs
  dynamic "enabled_log" {
    for_each = var.enabled_logs
    content {
      category = enabled_log.value
    }
  }

  # Metrics
  metric {
    category = "AllMetrics"
    enabled  = var.metrics_enabled
  }
}
