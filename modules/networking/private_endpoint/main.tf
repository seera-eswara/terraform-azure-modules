# Azure Private Endpoint
# Creates a private endpoint for secure connectivity to Azure services

resource "azurerm_private_endpoint" "pe" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.name}-connection"
    private_connection_resource_id = var.resource_id
    subresource_names              = var.subresources
    is_manual_connection           = var.is_manual_connection
  }

  # Optional: Private DNS zone group for DNS resolution
  dynamic "private_dns_zone_group" {
    for_each = length(var.private_dns_zone_ids) > 0 ? [1] : []
    content {
      name                 = "${var.name}-dns-group"
      private_dns_zone_ids = var.private_dns_zone_ids
    }
  }

  # Custom network interface configuration
  dynamic "custom_network_interface_name" {
    for_each = var.custom_network_interface_name != "" ? [1] : []
    content {
      value = var.custom_network_interface_name
    }
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [private_dns_zone_group]
  }
}

# Data source to get private endpoint network interface
data "azurerm_network_interface" "pe_nic" {
  count               = length(azurerm_private_endpoint.pe.network_interface_ids) > 0 ? 1 : 0
  name                = azurerm_private_endpoint.pe.network_interface_ids[0]
  resource_group_name = var.resource_group_name
}
