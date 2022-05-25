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


resource "azurerm_public_ip" "config" {
  count               = var.sku_name != "AZFW_Hub" ? var.public_ip_count : 0
  name                = "${var.name}-${count.index + 1}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  zones               = var.zones
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_public_ip" "managedment" {
  count               = var.management_subnet_id != null && var.sku_name != "AZFW_Hub" ? 1 : 0
  name                = "${var.name}-management-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  zones               = var.zones
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


resource "azurerm_firewall_policy" "this" {
  name                = "${var.name}-policy"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku_policy

  dynamic "dns" {
    for_each = var.proxy_enabled != false ? [1] : []
    content {
      proxy_enabled = true
      servers       = var.dns_servers != null ? var.dns_servers : null
    }
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_firewall" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  zones               = var.zones
  threat_intel_mode   = var.threat_intel_mode
  sku_tier            = var.sku_tier
  sku_name            = var.sku_name
  firewall_policy_id  = azurerm_firewall_policy.this.id

  dynamic "ip_configuration" {
    iterator = pip
    for_each = var.sku_name != "AZFW_Hub" ? azurerm_public_ip.config : []
    content {
      name                 = lower("fw_ip_config_${pip.value.name}")
      subnet_id            = contains([pip.value.name], "${var.name}-1-pip") ? var.subnet_id : null
      public_ip_address_id = pip.value.id
    }
  }

  dynamic "management_ip_configuration" {
    for_each = var.management_subnet_id != null ? [1] : []
    content {
      name                 = lower("fw_ip_management_${azurerm_public_ip.managedment[0].ip_address}")
      subnet_id            = var.management_subnet_id
      public_ip_address_id = azurerm_public_ip.managedment[0].id
    }
  }

  dynamic "virtual_hub" {
    for_each = var.virtual_hub_id != null && var.sku_name == "AZFW_Hub" ? [1] : []
    content {
      virtual_hub_id  = var.virtual_hub_id
      public_ip_count = var.pip_count
    }
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
