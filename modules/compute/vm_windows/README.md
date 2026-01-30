# Windows Virtual Machine Module

Deploys Windows VMs with security hardening, monitoring, and networking features.

## Features

- System-assigned managed identity
- Custom script extension support
- Diagnostic settings
- OS disk encryption
- Network interface with NSG
- Password-based authentication
- Monitoring with Log Analytics
- Windows Defender enrollment

## Usage

```hcl
module "vm_windows" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/vm_windows"

  name                = "myvm"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  subnet_id           = azurerm_subnet.app.id
  
  size = "Standard_D2s_v3"
  
  admin_username = "azureadmin"
  admin_password = random_password.vm_admin.result
  
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
}
```

## Outputs

- `id` - VM ID
- `name` - VM name
- `private_ip_address` - Private IP address
- `identity_principal_id` - Managed identity principal ID
