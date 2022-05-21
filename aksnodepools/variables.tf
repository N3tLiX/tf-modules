variable "node_pools" {
  description = "Subnets configuration"
  type = list(object({
    name                         = string
    kubernetes_cluster_id        = string
    vm_size                      = string
    mode                         = string
    node_labels                  = map(any)
    node_taints                  = list(string)
    zones                        = list(string)
    vnet_subnet_id               = string
    enable_auto_scaling          = bool
    enable_host_encryption       = bool
    enable_node_public_ip        = bool
    proximity_placement_group_id = string
    orchestrator_version         = string
    max_pods                     = number
    max_count                    = number
    min_count                    = number
    node_count                   = number
    os_disk_size_gb              = number
    os_disk_type                 = string
    os_type                      = string
    priority                     = string
    tags                         = map(any)
  }))
}
