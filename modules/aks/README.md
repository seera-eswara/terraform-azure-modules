## AKS Module

### Inputs
- **name**: Name of the AKS cluster (string)
- **location**: Azure region (string)
- **resource_group**: Resource group name (string)
- **vm_size**: VM size for system node pool (string)
- **node_count**: Node count for system node pool (number, default 3)
- **enable_oms_agent**: Enable OMS Agent for logging (bool, default true)
- **log_analytics_workspace_id**: Resource ID of Log Analytics workspace (string)

### Notes
- When `enable_oms_agent` is true, you must provide a valid `log_analytics_workspace_id`.
- This enables cluster logging via OMS Agent to satisfy tfsec `azure-container-logging` policy.
