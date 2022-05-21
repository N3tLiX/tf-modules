variable "identities" {
  description = "identity configuration"
  type = list(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = map(any)
  }))
}

variable "tags" {
  description = "(Optional) Specifies tags for all the resources"
  type        = map(any)
  default = {
    createdWith = "Terraform"
  }
}
