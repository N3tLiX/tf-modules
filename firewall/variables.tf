variable "name" {
  description = "(Required) Specifies the name of the Firewall. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = " (Required) The name of the resource group in which to create the resource. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "sku_name" {
  description = "(Optional) SKU name of the Firewall. Possible values are AZFW_Hub and AZFW_VNet. Changing this forces a new resource to be created."
  default     = "AZFW_VNet"
  type        = string

  validation {
    condition     = contains(["AZFW_VNet", "AZFW_Hub"], var.sku_name)
    error_message = "The SKU Tier is invalid."
  }
}

variable "sku_tier" {
  description = "(Optional) SKU tier of the Firewall. Possible values are Premium and Standard. Changing this forces a new resource to be created."
  default     = "Standard"
  type        = string

  validation {
    condition     = contains(["Premium", "Standard"], var.sku_tier)
    error_message = "The SKU Tier is invalid."
  }
}

variable "threat_intel_mode" {
  description = " (Optional) The operation mode for threat intelligence-based filtering. Possible values are: Off, Alert,Deny and (empty string). Defaults to Alert."
  default     = "Alert"
  type        = string

  validation {
    condition     = contains(["Off", "Alert", "Deny", ""], var.threat_intel_mode)
    error_message = "The threat intel mode is invalid."
  }
}

variable "zones" {
  description = "Specifies the availability zones of the Azure Firewall"
  default     = ["1", "2", "3"]
  type        = list(string)
}

variable "public_ip_count" {
  description = "(Optional) Specifies the number of public IPs to assign to the Firewall. Defaults to 1."
  type        = number
  default     = 1
}

variable "subnet_id" {
  description = "(Optional) Reference to the subnet associated with the IP Configuration."
  type        = string
  default     = null
}

variable "virtual_hub_id" {
  description = "virtual_hub block supports the following: (Required) Specifies the ID of the Virtual Hub where the Firewall resides in."
  type        = string
  default     = null
}

variable "management_name" {
  description = "(Required) Specifies the name of the IP Configuration."
  type        = string
  default     = "fw_ip_management_config"
}

variable "management_subnet_id" {
  description = "(Required) Reference to the subnet associated with the IP Configuration. Changing this forces a new resource to be created. The Management Subnet used for the Firewall must have the name AzureFirewallManagementSubnet and the subnet mask must be at least a /26."
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) Specifies the tags of the storage account"
  default     = {}
}


variable "sku_policy" {
  description = "(Optional) The SKU Tier of the Firewall Policy. Possible values are Standard, Premium. Changing this forces a new Firewall Policy to be created."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Premium", "Standard"], var.sku_policy)
    error_message = "The SKU Tier is invalid."
  }
}

variable "proxy_enabled" {
  description = "(Optional) Whether to enable DNS proxy on Firewalls attached to this Firewall Policy? Defaults to false."
  type        = bool
  default     = false
}

variable "dns_servers" {
  description = "(Optional) A list of custom DNS servers' IP addresses."
  type        = list(string)
  default     = null
}
