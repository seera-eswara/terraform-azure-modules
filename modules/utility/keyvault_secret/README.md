# Azure Key Vault Secret Module

Terraform module for managing Azure Key Vault secrets with versioning and expiration.

## Features

- Secret creation and management
- Content type specification
- Expiration date support
- Not-before date support
- Tags support
- Automatic versioning

## Usage

### Basic Secret

```hcl
module "secret" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/keyvault_secret"
  
  name         = "database-password"
  value        = random_password.db.result
  key_vault_id = azurerm_key_vault.this.id
  
  content_type = "password"
}
```

### With Expiration

```hcl
module "secret" {
  source = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/keyvault_secret"
  
  name         = "api-key"
  value        = var.api_key
  key_vault_id = azurerm_key_vault.this.id
  
  content_type    = "api-key"
  expiration_date = "2026-12-31T23:59:59Z"
  
  tags = {
    Rotation = "yearly"
    Owner    = "platform-team"
  }
}
```

### Multiple Secrets

```hcl
locals {
  secrets = {
    "db-username" = {
      value        = "admin"
      content_type = "username"
    }
    "db-password" = {
      value        = random_password.db.result
      content_type = "password"
    }
    "connection-string" = {
      value        = azurerm_sql_server.this.connection_string
      content_type = "connection-string"
    }
  }
}

module "secrets" {
  source   = "git::https://github.com/your-org/terraform-azure-modules.git//modules/utility/keyvault_secret"
  for_each = local.secrets
  
  name         = each.key
  value        = each.value.value
  key_vault_id = azurerm_key_vault.this.id
  content_type = each.value.content_type
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.6.6 |
| azurerm | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 4.0 |

## Resources

| Name | Type |
|------|------|
| azurerm_key_vault_secret.this | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Secret name | `string` | n/a | yes |
| value | Secret value | `string` | n/a | yes |
| key_vault_id | Key Vault ID | `string` | n/a | yes |
| content_type | Content type hint | `string` | `null` | no |
| expiration_date | Expiration date (RFC3339) | `string` | `null` | no |
| not_before_date | Not-before date (RFC3339) | `string` | `null` | no |
| tags | Secret tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Secret ID |
| version | Secret version |
| versionless_id | Versionless secret ID |

## Notes

- Secret values are marked as sensitive
- Expiration dates must be in RFC3339 format (e.g., "2026-12-31T23:59:59Z")
- Use content_type to document secret purpose
- Consider implementing secret rotation policies
