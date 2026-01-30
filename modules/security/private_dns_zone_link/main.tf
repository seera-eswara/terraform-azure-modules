# Azure Private DNS Zone Virtual Network Link
# Creates a link between a private DNS zone and a virtual network

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  name                  = var.name
  private_dns_zone_name = split("/", var.private_dns_zone_id)[8]
  resource_group_name   = split("/", var.private_dns_zone_id)[4]
  virtual_network_id    = var.virtual_network_id
  registration_enabled  = var.registration_enabled

  tags = var.tags
}

# Data source to get the private DNS zone name and RG
data "azurerm_private_dns_zone" "zone" {
  name                = split("/", var.private_dns_zone_id)[8]
  resource_group_name = split("/", var.private_dns_zone_id)[4]
}
