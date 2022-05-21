variable "key_vault_id" {
  description = "(Required) Specifies the ID of KeyVault."
  type        = string
}

variable "secrets" {
  description = "(Required) secret configuration"
  type = list(object({
    name  = string
    value = string
  }))
}
