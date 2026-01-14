provider "azurerm" {
  features {}
}

run "aks_private_cluster" {
  command = plan

  module {
    source = "./modules/aks"
  }

  variables {
    name           = "test-aks"
    location       = "eastus"
    resource_group = "rg-test"
    vm_size        = "Standard_D2s_v5"
    node_count     = 1
  }

  assert {
    condition     = output.private_cluster_enabled == true
    error_message = "AKS must be private"
  }
}
