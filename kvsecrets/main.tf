terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }

  required_version = ">= 0.14.9"
}

resource "azurerm_key_vault_secret" "this" {
  for_each     = { for secret in var.secrets : secret.name => secret }
  name         = each.key
  value        = each.value.value
  key_vault_id = var.key_vault_id
}
