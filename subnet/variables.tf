variable "virtual_network_name" {
  description = "(Required) The name of the virtual network. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to get the data of the the virtual network."
  type        = string
}

variable "subnets" {
  description = "(Required) Manages a subnet. Subnets represent network segments within the IP space defined by the virtual networ (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)."
  type = list(object({
    name                                           = string
    address_prefixes                               = list(string)
    enforce_private_link_endpoint_network_policies = bool
    enforce_private_link_service_network_policies  = bool
    service_endpoints                              = list(string)
    deligation = object({
      name = string
      service_delegation = object({
        actions = list(string)
        name    = string
      })
    })
  }))
}
