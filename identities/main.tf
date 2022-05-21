terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }

  required_version = ">= 0.14.9"
}

resource "azurerm_user_assigned_identity" "identity" {
  for_each = { for identity in var.identities : identity.name => identity }

  name                = "${each.key}_Identity"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
