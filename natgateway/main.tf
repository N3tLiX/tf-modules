terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }

  required_version = ">= 0.14.9"
}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.tags, local.module_tag)
}

resource "azurerm_public_ip" "this" {
  name                    = "${var.name}-pip"
  resource_group_name     = var.resource_group_name
  location                = var.location
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  allocation_method       = "Static"
  ip_version              = "IPv4"
  sku                     = var.sku
  tags                    = var.tags
  lifecycle {
    ignore_changes = [
      tags,
      ip_tags,
      idle_timeout_in_minutes
    ]
  }
}

resource "azurerm_public_ip_prefix" "this" {
  count               = var.prefix_enabled == true ? 1 : 0
  name                = "${var.name}-pipprefix"
  location            = azurerm_public_ip.this.location
  resource_group_name = azurerm_public_ip.this.resource_group_name
  prefix_length       = 30
}

resource "azurerm_nat_gateway" "this" {
  name                    = var.name
  resource_group_name     = azurerm_public_ip.this.resource_group_name
  location                = azurerm_public_ip.this.location
  idle_timeout_in_minutes = 4
  sku_name                = "Standard"
  tags                    = var.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_nat_gateway_public_ip_association" "this" {
  nat_gateway_id       = azurerm_nat_gateway.this.id
  public_ip_address_id = azurerm_public_ip.this.id
}

resource "azurerm_nat_gateway_public_ip_prefix_association" "this" {
  count               = var.prefix_enabled == true ? 1 : 0
  nat_gateway_id      = azurerm_nat_gateway.this.id
  public_ip_prefix_id = azurerm_public_ip_prefix.this[0].id
}

resource "azurerm_subnet_nat_gateway_association" "this" {
  for_each       = var.subnets_to_associate
  subnet_id      = "/subscriptions/${each.value.subscription_id}/resourceGroups/${each.value.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${each.value.virtual_network_name}/subnets/${each.key}"
  nat_gateway_id = azurerm_nat_gateway.this.id
}
