terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }

  required_version = ">= 0.14.9"
}

resource "azurerm_key_vault_access_policy" "group" {
  for_each     = { for access in var.access_objects : access.name => access }
  key_vault_id = var.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = each.value.object_id
  # object_id    = data.azuread_group.group[each.key].object_id
  certificate_permissions = each.value.certificate_permissions
  key_permissions         = each.value.key_permissions
  secret_permissions      = each.value.secret_permissions
  storage_permissions     = each.value.storage_permissions
}
