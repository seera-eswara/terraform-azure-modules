locals {
  # Standardized naming components
  app_code    = lower(var.app_code)
  environment = lower(var.environment)
  region_short = lookup(local.region_abbreviations, lower(var.location), "unk")
  instance    = var.instance != null ? format("%02d", var.instance) : null

  # Azure region abbreviations for consistent short names
  region_abbreviations = {
    "eastus"        = "eus"
    "eastus2"       = "eus2"
    "westus"        = "wus"
    "westus2"       = "wus2"
    "centralus"     = "cus"
    "northcentralus" = "ncus"
    "southcentralus" = "scus"
    "westcentralus" = "wcus"
    "canadacentral" = "cac"
    "canadaeast"    = "cae"
    "brazilsouth"   = "brs"
    "northeurope"   = "neu"
    "westeurope"    = "weu"
    "uksouth"       = "uks"
    "ukwest"        = "ukw"
    "francecentral" = "frc"
    "germanywestcentral" = "gwc"
    "switzerlandnorth" = "chn"
    "norwayeast"    = "noe"
    "swedencentral" = "sec"
    "japaneast"     = "jpe"
    "japanwest"     = "jpw"
    "australiaeast" = "aue"
    "australiasoutheast" = "ause"
    "southeastasia" = "sea"
    "eastasia"      = "eas"
    "southindia"    = "ins"
    "centralindia"  = "inc"
    "westindia"     = "inw"
  }

  # Standard format for module-level resources: <type>-<app>-<module>-<env>-<region>-<instance>
  base_name = join("-", compact([
    "%s",  # Resource type placeholder
    local.app_code,
    var.module != null ? lower(var.module) : null,  # Include module for resource isolation
    local.environment,
    local.region_short,
    local.instance
  ]))

  # Special format for storage accounts (lowercase, no hyphens, max 24 chars)
  storage_base_name = substr(
    replace(
      join("", compact([
        "%s",  # Resource type placeholder
        local.app_code,
        var.module != null ? lower(var.module) : null,  # Include module
        local.environment,
        local.region_short,
        local.instance
      ])),
      "-", ""
    ),
    0, 24
  )
}

# Generate names for each resource type
locals {
  # Resource type prefixes following Azure CAF
  names = {
    # Management & Governance
    subscription             = join("-", compact([lower(var.app_code), var.module != null ? lower(var.module) : null, local.environment]))
    management_group         = "mg-${local.app_code}"
    
    # Compute
    virtual_machine          = format(local.base_name, "vm")
    virtual_machine_scale_set = format(local.base_name, "vmss")
    availability_set         = format(local.base_name, "avail")
    
    # Containers
    aks_cluster              = format(local.base_name, "aks")
    container_registry       = format(local.base_name, "acr")
    container_instance       = format(local.base_name, "aci")
    
    # Networking
    virtual_network          = format(local.base_name, "vnet")
    subnet                   = format(local.base_name, "snet")
    network_interface        = format(local.base_name, "nic")
    network_security_group   = format(local.base_name, "nsg")
    public_ip                = format(local.base_name, "pip")
    load_balancer            = format(local.base_name, "lb")
    application_gateway      = format(local.base_name, "agw")
    route_table              = format(local.base_name, "rt")
    
    # Storage
    storage_account          = format(local.storage_base_name, "st")
    
    # Databases
    sql_server               = format(local.base_name, "sql")
    sql_database             = format(local.base_name, "sqldb")
    cosmos_db                = format(local.base_name, "cosmos")
    mysql_server             = format(local.base_name, "mysql")
    postgresql_server        = format(local.base_name, "psql")
    redis_cache              = format(local.base_name, "redis")
    
    # Monitoring & Management
    log_analytics_workspace  = format(local.base_name, "law")
    application_insights     = format(local.base_name, "appi")
    automation_account       = format(local.base_name, "aa")
    recovery_services_vault  = format(local.base_name, "rsv")
    
    # Security
    key_vault                = format(local.base_name, "kv")
    
    # Resource Management
    resource_group           = format(local.base_name, "rg")
    
    # App Services
    app_service_plan         = format(local.base_name, "asp")
    app_service              = format(local.base_name, "app")
    function_app             = format(local.base_name, "func")
    
    # Data & Analytics
    data_factory             = format(local.base_name, "adf")
    synapse_workspace        = format(local.base_name, "synw")
    databricks_workspace     = format(local.base_name, "dbw")
    event_hub_namespace      = format(local.base_name, "evhns")
    event_hub                = format(local.base_name, "evh")
    service_bus_namespace    = format(local.base_name, "sbns")
    service_bus_queue        = format(local.base_name, "sbq")
  }

  # Common tags to apply across all resources
  tags = merge(
    {
      AppCode     = var.app_code
      Environment = var.environment
      ManagedBy   = "Terraform"
      Location    = var.location
    },
    var.additional_tags
  )
}
