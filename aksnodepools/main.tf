terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }

  required_version = ">= 0.14.9"
}

resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  for_each = { for node_pool in var.node_pools : node_pool.name => node_pool }

  name                         = each.key
  kubernetes_cluster_id        = each.value.kubernetes_cluster_id
  vm_size                      = each.value.vm_size
  mode                         = each.value.mode
  node_labels                  = each.value.node_labels
  node_taints                  = each.value.node_taints
  zones                        = each.value.zones
  vnet_subnet_id               = each.value.vnet_subnet_id
  enable_auto_scaling          = each.value.enable_auto_scaling
  enable_host_encryption       = each.value.enable_host_encryption
  enable_node_public_ip        = each.value.enable_node_public_ip
  proximity_placement_group_id = each.value.proximity_placement_group_id
  orchestrator_version         = each.value.orchestrator_version
  max_pods                     = each.value.max_pods
  max_count                    = each.value.max_count
  min_count                    = each.value.min_count
  node_count                   = each.value.node_count
  os_disk_size_gb              = each.value.os_disk_size_gb
  os_disk_type                 = each.value.os_disk_type
  os_type                      = each.value.os_type
  priority                     = each.value.priority
  tags                         = each.value.tags
  lifecycle {
    ignore_changes = [
      orchestrator_version,
      tags
    ]
  }
}
