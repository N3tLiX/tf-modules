variable "name" {
  description = "(Required) Specifies the name of the NAT Gateway. Changing this forces a new resource to be created"
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Specifies the resource group name of the virtual machine"
  type        = string
}

variable "location" {
  description = " (Required) Specifies the supported Azure location where the NAT Gateway should exist. Changing this forces a new resource to be created."
  type        = string
}

variable "sku" {
  description = "(Required) Specifies the storage account type of the os disk of the virtual machine"
  default     = "Standard"
  type        = string

  validation {
    condition     = contains(["Standard", "Basic"], var.sku)
    error_message = "The Public IP SKU is invalid. (check: https://docs.microsoft.com/en-us/azure/virtual-network/ip-services/public-ip-addresses#sku)."
  }
}

variable "idle_timeout_in_minutes" {
  description = "(Optional) Specifies the timeout for the TCP idle connection"
  type        = number
  default     = 4
}

variable "prefix_enabled" {
  description = " (Optional) Enable public ip prefix (true=enable)"
  type        = bool
  default     = false
}

variable "prefix_length" {
  description = "(Optional) The number of bits of the prefix"
  type        = number
  default     = 30

  validation {
    condition     = contains([28, 29, 30, 31], var.prefix_length)
    error_message = "The number of bits of the prefix is invalid. (check: https://docs.microsoft.com/en-us/azure/virtual-network/ip-services/public-ip-address-prefix)."
  }
}
variable "subnets_to_associate" {
  description = "(Optional) Specifies the subscription id, resource group name, and name of the subnets to associate"
  type        = map(any)
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "A map of the tags to use on the resources that are deployed with this module."

  default = {
    source = "Deployed by Terraform"
  }
}
