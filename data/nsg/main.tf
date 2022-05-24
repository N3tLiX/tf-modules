terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }

  required_version = ">= 0.14.9"
}

data "azurerm_network_security_group" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
}
