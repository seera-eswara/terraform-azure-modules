variable "name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "location" {
  type        = string
  description = "Azure region where the AKS cluster will be deployed"
}

variable "resource_group" {
  type        = string
  description = "Name of the resource group"
}

variable "vm_size" {
  type        = string
  description = "Allowed SKUs enforced by policy"
}

variable "node_count" {
  type    = number
  default = 3
}
