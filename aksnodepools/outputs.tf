output "ids" {
  description = "Specifies the resource id of the node pool"
  value       = { for node_pool in azurerm_kubernetes_cluster_node_pool.node_pool : node_pool.name => node_pool.id }
}
