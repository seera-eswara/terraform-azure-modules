output "id" {
  description = "The ID of the Redis cache"
  value       = azurerm_redis_cache.redis.id
}

output "hostname" {
  description = "The hostname of the Redis cache"
  value       = azurerm_redis_cache.redis.hostname
}

output "port" {
  description = "The port of the Redis cache"
  value       = azurerm_redis_cache.redis.port
}

output "ssl_port" {
  description = "The SSL port of the Redis cache"
  value       = azurerm_redis_cache.redis.ssl_port
}

output "primary_access_key" {
  description = "The primary access key for Redis authentication"
  value       = azurerm_redis_cache.redis.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "The secondary access key for Redis authentication"
  value       = azurerm_redis_cache.redis.secondary_access_key
  sensitive   = true
}

output "primary_connection_string" {
  description = "The primary connection string"
  value       = azurerm_redis_cache.redis.primary_connection_string
  sensitive   = true
}

output "secondary_connection_string" {
  description = "The secondary connection string"
  value       = azurerm_redis_cache.redis.secondary_connection_string
  sensitive   = true
}
