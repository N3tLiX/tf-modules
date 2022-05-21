variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the route table. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "name" {
  description = " (Required) The name of the route table. Changing this forces a new resource to be created."
  type        = string
}

variable "disable_bgp_route_propagation" {
  description = "(Optional) Boolean flag which controls propagation of routes learned by BGP on that route table. True means disable."
  type        = bool
  default     = false
}

variable "routes" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  }))
}

variable "subnets_to_associate" {
  description = "(Optional) Specifies the subscription id, resource group name, and name of the subnets to associate"
  type        = map(any)
  default     = {}
}

variable "tags" {
  description = "(Optional) Specifies the tags of the storage account"
  default     = {}
}
