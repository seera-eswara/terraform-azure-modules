# Azure Terraform Modules Catalog

Complete reference of all available Terraform modules for deploying Azure infrastructure with security, monitoring, and networking best practices.

---

## 📊 Modules Overview

| Category | Module | Purpose | Key Features |
|----------|--------|---------|--------------|
| **Compute** | app_service | Deploy App Services | Managed identity, private endpoint, diagnostics |
| | function_app | Deploy Azure Functions | Runtime support, VNet integration, monitoring |
| | container_app | Deploy Container Apps | Multi-container, auto-scaling, ingress |
| | aks_cluster | Deploy Kubernetes | Private cluster, RBAC, monitoring |
| | vm_linux | Deploy Linux VMs | SSH auth, monitoring, custom extensions |
| | vm_windows | Deploy Windows VMs | Password auth, monitoring, extensions |
| | app_service_plan | Deploy App Plans | Multi-tier support, auto-scaling |
| **Data** | storage_account | Deploy Storage | Firewall, private endpoint, soft delete |
| | sql_server | Deploy SQL Server | Firewall, audit, RBAC |
| | sql_database | Deploy SQL Database | Threat detection, backup, geo-replication |
| | cosmos_account | Deploy Cosmos DB | Firewall, auto-scaling, private endpoint |
| | redis_cache | Deploy Redis | SSL, cluster mode, firewall |
| | eventhub_namespace | Deploy Event Hubs | Auto-inflate, firewall, managed identity |
| | servicebus_namespace | Deploy Service Bus | Premium partitions, firewall, RBAC |
| | keyvault | Deploy Key Vault | RBAC, network rules, access policies |
| **Networking** | private_endpoint | Deploy Private Endpoints | DNS integration, flexible subresources |
| | nsg | Deploy Network Security Groups | Dynamic rules, diagnostics, flow logs |
| | vnet | Deploy Virtual Networks | Subnets, service endpoints, diagnostics |
| **Identity** | managed_identity | Deploy User Identities | RBAC-ready, tagging |
| | role_assignment | Assign Roles | Flexible scope, validation |
| **Monitoring** | diagnostic_settings | Configure Diagnostics | Flexible logs/metrics |
| | log_analytics_workspace | Deploy Log Analytics | Retention, solutions |
| | action_group | Deploy Action Groups | Email, webhook, SMS |
| | application_insights | Deploy Application Insights | Web/mobile monitoring, retention |
| **Security** | policy_assignment | Assign Policies | Governance enforcement |
| | private_dns_zone_link | Link DNS Zones | PaaS service resolution |
| **Utility** | resource_group | Create Resource Groups | Naming, tagging, locks |
| | storage_container | Create Storage Containers | Access control, metadata |
| | acr | Deploy Container Registry | Geo-replication, private endpoint, retention |
| | keyvault_secret | Manage Key Vault Secrets | Expiration, versioning, tags |
| | tags | Generate Standard Tags | CAF-aligned, cost tracking, compliance |

**Total: 31 Modules** organized in **compute/**, **data/**, **networking/**, **identity/**, **monitoring/**, **security/**, **utility/**

---

## 🔴 Compute Modules

### app_service
Deploy Azure App Services with security hardening.

```hcl
module "app_service" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/compute/app_service"
  
  name                = "myapp"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  app_service_plan_id = module.app_service_plan.id
  
  os_type = "Linux"
  create_private_endpoint = true
  private_endpoint_subnet_id = azurerm_subnet.private_endpoints.id
  
  enable_diagnostics = true
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
}
```

**Enforces**: Managed identity, HTTPS, diagnostics, private endpoint, network restrictions

---

### function_app
Deploy Azure Functions with runtime flexibility.

```hcl
module "function_app" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/compute/function_app"
  
  name = "myfunction"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  app_service_plan_id = module.app_service_plan.id
  
  storage_account_name = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key
  
  runtime_name = "node"
  runtime_version = "4"
  
  enable_diagnostics = true
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
}
```

**Enforces**: Managed identity, VNet integration, diagnostics, HTTPS

---

### container_app
Deploy Azure Container Apps.

```hcl
module "container_app" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/compute/container_app"
  
  name = "myapp"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  container_app_environment_id = module.container_app_env.id
  
  containers = {
    app = {
      name   = "myapp"
      image  = "mcr.microsoft.com/app:latest"
      cpu    = "0.25"
      memory = "0.5Gi"
      port   = 80
    }
  }
}
```

**Enforces**: Managed identity, auto-scaling, ingress configuration

---

### aks_cluster
Deploy production-grade Kubernetes.

```hcl
module "aks_cluster" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/compute/aks_cluster"
  
  name = "mycluster"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  
  private_cluster_enabled = true
  enable_rbac = true
  enable_azure_policy = true
  
  default_node_pool = {
    name       = "system"
    node_count = 1
    vm_size    = "Standard_D2s_v3"
  }
  
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
}
```

**Enforces**: Private cluster, RBAC, Azure Policy, monitoring, security policies

---

### vm_linux & vm_windows
Deploy VMs with monitoring.

```hcl
module "vm_linux" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/compute/vm_linux"
  
  name = "myvm"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  subnet_id = azurerm_subnet.app.id
  
  admin_username = "azureuser"
  admin_ssh_key = file("~/.ssh/id_rsa.pub")
  
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
}
```

**Enforces**: Managed identity, SSH auth (Linux), monitoring, diagnostics

---

### app_service_plan
Deploy App Service Plans.

```hcl
module "app_service_plan" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/compute/app_service_plan"
  
  name = "myplan"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  
  os_type = "Linux"
  sku_tier = "Standard"
  sku_size = "S1"
  
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
}
```

**Enforces**: Diagnostics, monitoring

---

## 🟢 Data Modules

### storage_account
Deploy Storage with firewall and encryption.

```hcl
module "storage_account" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/data/storage_account"
  
  name = "mystorageacct"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  
  account_replication_type = "GRS"
  https_traffic_only_enabled = true
  
  enable_firewall = true
  firewall_virtual_network_subnet_ids = [azurerm_subnet.app.id]
  
  create_private_endpoint = true
  private_endpoint_subnet_id = azurerm_subnet.private_endpoints.id
}
```

**Enforces**: Firewall, private endpoint, HTTPS, versioning, soft delete, RBAC

---

### sql_server & sql_database
Deploy SQL infrastructure with auditing.

```hcl
module "sql_server" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/data/sql_server"
  
  name = "myserver"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  
  administrator_login = "sqladmin"
  administrator_login_password = random_password.sql.result
  
  create_private_endpoint = true
  private_endpoint_subnet_id = azurerm_subnet.data.id
  
  enable_audit = true
  audit_retention_days = 30
}

module "sql_database" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/data/sql_database"
  
  name = "mydb"
  server_id = module.sql_server.id
  
  sku_name = "Standard"
  
  enable_threat_detection = true
  enable_diagnostics = true
}
```

**Enforces**: Firewall, auditing, threat detection, backup, geo-replication, diagnostics

---

### cosmos_account, redis_cache, eventhub_namespace, servicebus_namespace
Deploy distributed data services.

```hcl
module "cosmos_account" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/data/cosmos_account"
  
  name = "myaccount"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  
  kind = "GlobalDocumentDB"
  create_private_endpoint = true
  
  enable_firewall = true
  firewall_virtual_network_subnet_ids = [azurerm_subnet.data.id]
}

module "redis_cache" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/data/redis_cache"
  
  name = "myredis"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  
  sku_name = "Basic"
  family   = "C"
  
  enable_ssl = true
  minimum_tls_version = "1.2"
}
```

**Enforces**: Firewall, private endpoint, SSL/encryption, RBAC, diagnostics, managed identity

---

## 🔵 Networking Modules

### private_endpoint
Generic private endpoint module.

```hcl
module "private_endpoint" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/networking/private_endpoint"
  
  name = "myapp-pe"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  
  subnet_id = azurerm_subnet.private_endpoints.id
  resource_id = azurerm_app_service.this.id
  subresources = ["sites"]
}
```

**Enforces**: DNS integration, resource validation

---

### nsg & nsg_rules
Network Security Groups management.

```hcl
module "nsg" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/networking/nsg"
  
  name = "app-nsg"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  
  rules = {
    "AllowHTTPS" = {
      priority  = 100
      direction = "Inbound"
      access    = "Allow"
      protocol  = "Tcp"
      source_port_range = "*"
      destination_port_range = "443"
    }
  }
  
  enable_diagnostics = true
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
}
```

**Enforces**: Diagnostics, consistent naming

---

## 🟡 Identity Modules

### managed_identity, role_assignment, key_vault_access_policy
Identity and access management.

```hcl
module "managed_identity" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/identity/managed_identity"
  
  name = "app-identity"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
}

module "role_assignment" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/identity/role_assignment"
  
  principal_id = module.managed_identity.principal_id
  role_definition_name = "Contributor"
  scope = azurerm_resource_group.this.id
}

module "kv_policy" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/identity/key_vault_access_policy"
  
  key_vault_id = azurerm_key_vault.this.id
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = module.managed_identity.principal_id
  
  secret_permissions = ["Get", "List"]
  key_permissions = ["Get", "List"]
}
```

**Enforces**: Least privilege, RBAC, naming standards

---

## 🟣 Monitoring Modules

### diagnostic_settings, log_analytics_workspace, action_group, alert_rules
Observability infrastructure.

```hcl
module "log_analytics" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/monitoring/log_analytics_workspace"
  
  name = "mylaw"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  
  sku = "PerGB2018"
  retention_in_days = 30
}

module "action_group" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/monitoring/action_group"
  
  name = "critical-alerts"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  short_name = "critical"
  
  email_receivers = {
    "oncall" = {
      email_address = "oncall@company.com"
    }
  }
}

module "alert" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/monitoring/alert_rules"
  
  name = "high-cpu-alert"
  resource_group_name = azurerm_resource_group.this.name
  scopes = [azurerm_virtual_machine.this.id]
  
  severity = 2
  metric_name = "Percentage CPU"
  operator = "GreaterThan"
  threshold = 80
}
```

**Enforces**: Central logging, consistent metrics, alerting standards

---

## 🔐 Security Modules

### defender_plan_assignment, policy_assignment, private_dns_zone_link
Governance and compliance.

```hcl
module "policy" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/security/policy_assignment"
  
  policy_definition_id = "/subscriptions/.../providers/Microsoft.Authorization/policyDefinitions/..."
  management_group_id = data.azurerm_management_group.applications.id
  
  enforcement_mode = "Default"
}

module "private_dns_link" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/security/private_dns_zone_link"
  
  private_dns_zone_id = azurerm_private_dns_zone.blob.id
  virtual_network_id = azurerm_virtual_network.app.id
  
  registration_enabled = false
}
```

**Enforces**: Governance, compliance, security baselines

---

## 📚 Quick Start Examples

### Complete App Stack
```hcl
# Plan
module "app_service_plan" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/compute/app_service_plan"
  name = "myplan"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  os_type = "Linux"
  sku_tier = "Standard"
  sku_size = "S1"
  log_analytics_workspace_id = module.log_analytics.id
}

# App Service
module "app_service" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/compute/app_service"
  name = "myapp"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  app_service_plan_id = module.app_service_plan.id
  os_type = "Linux"
  create_private_endpoint = true
  private_endpoint_subnet_id = azurerm_subnet.private_endpoints.id
  enable_diagnostics = true
  log_analytics_workspace_id = module.log_analytics.id
}

# Storage
module "storage" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/data/storage_account"
  name = "mystg"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  enable_firewall = true
  firewall_virtual_network_subnet_ids = [azurerm_subnet.app.id]
  create_private_endpoint = true
  private_endpoint_subnet_id = azurerm_subnet.private_endpoints.id
}

# Key Vault
module "key_vault" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/data/keyvault"
  name = "myvault"
  location = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  enable_rbac_authorization = true
}
```

---

## ✅ Best Practices Enforced

All modules enforce:

- ✅ **Security**: HTTPS, TLS 1.2+, firewall rules, private endpoints
- ✅ **Identity**: System-assigned managed identities, RBAC
- ✅ **Networking**: Private endpoints, VNet integration, network rules
- ✅ **Monitoring**: Diagnostic settings, Log Analytics integration
- ✅ **Naming**: Consistent CAF-based naming conventions
- ✅ **Tagging**: Comprehensive resource tagging
- ✅ **Compliance**: Audit logging, threat detection where applicable
- ✅ **High Availability**: Zone redundancy, replication options
- ✅ **Disaster Recovery**: Backup policies, geo-replication

---

## 🚀 Deployment

All modules support Terraform 1.6.6+ with AzureRM provider 4.57.0+.

```bash
terraform init
terraform plan -var-file=env.tfvars
terraform apply
```

---

## 📖 Documentation

- Each module has comprehensive README.md
- All variables documented with validation
- Example usage in each module's README
- Security considerations documented
- Cost optimization notes included

---

## 🛠️ Utility Modules

The **utility/** category provides helper modules for common infrastructure patterns:

### resource_group
Create resource groups with locks and consistent tagging.

```hcl
module "rg" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/resource_group"
  
  name     = "rg-myapp-prod"
  location = "eastus"
  
  create_lock = true
  lock_level  = "CanNotDelete"
  
  tags = module.tags.tags
}
```

### storage_container
Manage storage containers with access control.

```hcl
module "container" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/storage_container"
  
  name                  = "uploads"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}
```

### acr (Container Registry)
Deploy Azure Container Registry with geo-replication.

```hcl
module "acr" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/acr"
  
  name                = "myacr"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Premium"
  
  create_private_endpoint    = true
  private_endpoint_subnet_id = azurerm_subnet.pe.id
  
  georeplications = [
    { location = "westus2", zone_redundancy_enabled = true }
  ]
}
```

### keyvault_secret
Manage Key Vault secrets with expiration.

```hcl
module "secret" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/keyvault_secret"
  
  name            = "db-password"
  value           = random_password.db.result
  key_vault_id    = azurerm_key_vault.this.id
  content_type    = "password"
  expiration_date = "2027-01-01T00:00:00Z"
}
```

### tags
Generate standardized tags for all resources.

```hcl
module "tags" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/tags"
  
  environment = "production"
  application = "customer-portal"
  cost_center = "IT-OPS"
  
  custom_tags = {
    Compliance = "SOC2"
    SLA        = "99.95"
  }
}

# Use tags in all resources
resource "azurerm_resource_group" "this" {
  name     = "rg-app-prod"
  location = "eastus"
  tags     = module.tags.tags  # ← Apply standard tags
}
```

---

**Last Updated**: January 29, 2026
**Total Modules**: 29
**Categories**: 7 (Compute, Data, Networking, Identity, Monitoring, Security, Utility)
**Organization**: Categorized folder structure for easy discovery
