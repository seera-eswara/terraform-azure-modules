resource "azurerm_network_interface" "this" {
  name                = "${var.name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "testConfiguration"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "this" {
  count                     = var.network_security_group_id != null ? 1 : 0
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = var.network_security_group_id
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  vm_size             = var.size

  admin_username = var.admin_username

  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_key
  }

  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# VM Extension for monitoring
resource "azurerm_virtual_machine_extension" "monitoring" {
  count                      = var.log_analytics_workspace_id != null ? 1 : 0
  name                       = "OMSAgentForLinux"
  virtual_machine_id         = azurerm_linux_virtual_machine.this.id
  publisher                  = "Microsoft.EnterpriseCloud.Monitoring"
  type                       = "OmsAgentForLinux"
  type_handler_version       = "1.13"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    workspaceId = data.azurerm_log_analytics_workspace.this[0].workspace_id
  })

  protected_settings = jsonencode({
    workspaceKey = data.azurerm_log_analytics_workspace.this[0].primary_shared_key
  })

  depends_on = [azurerm_linux_virtual_machine.this]
}

data "azurerm_log_analytics_workspace" "this" {
  count               = var.log_analytics_workspace_id != null ? 1 : 0
  resource_group_name = var.resource_group_name
  workspace_id        = data.azurerm_log_analytics_workspace.this[0].workspace_id
}

# Diagnostic settings
resource "azurerm_monitor_diagnostic_setting" "this" {
  count                      = var.enable_diagnostics && var.log_analytics_workspace_id != null ? 1 : 0
  name                       = "${var.name}-diag"
  target_resource_id         = azurerm_linux_virtual_machine.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}
