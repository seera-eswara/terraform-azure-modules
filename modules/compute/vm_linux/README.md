# Linux Virtual Machine Module

Deploys Linux VMs with security hardening, monitoring, and networking features.

## Features

- System-assigned managed identity
- Custom script extension support
- Diagnostic settings
- OS disk encryption
- Network interface with NSG
- SSH key-based authentication
- Monitoring with Log Analytics

## Usage

```hcl
module "vm_linux" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/vm_linux"

  name                = "myvm"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = azurerm_subnet.app.id
  
  size = "Standard_D2s_v3"
  
  admin_username = "azureuser"
  admin_ssh_key  = file("~/.ssh/id_rsa.pub")
  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
  
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
}
```

## Outputs

- `id` - VM ID
- `name` - VM name
- `private_ip_address` - Private IP address
- `identity_principal_id` - Managed identity principal ID
