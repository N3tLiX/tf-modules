output "name" {
  description = "Specifies the name of the virtual network"
  value       = azurerm_virtual_network.this.name
}

output "vnet_id" {
  description = "Specifies the resource id of the virtual network"
  value       = azurerm_virtual_network.this.id
}

output "vnet_address_space" {
  description = "Conatins a list of address spaces of the virtual network"
  value       = azurerm_virtual_network.this.address_space
}

output "subnet_names" {
  description = "Contains a list of the resource name of the subnets"
  value       = module.subnets.names
}

output "subnet_names_services" {
  description = "Contains a list of the resource name of the subnets"
  value       = module.subnets.names_services
}

output "subnet_ids" {
  description = "Contains a list of the resource id of the subnets"
  value       = module.subnets.ids
}

output "subnet_address_prefixes" {
  description = "Contains a list of the address prefixes of the subnets"
  value       = module.subnets.address_prefixes
}
