output "vnet_name" {
  description = "Specifies the name of the virtual network"
  value       = data.azurerm_virtual_network.this.name
}

output "vnet_id" {
  description = "Specifies the resource id of the virtual network"
  value       = data.azurerm_virtual_network.this.id
}

output "vnet_address_space" {
  description = "Conatins a list of address spaces of the virtual network"
  value       = data.azurerm_virtual_network.this.address_space
}

output "subnet_ids" {
  description = "Contains a list of the the resource id of the subnets"
  value       = { for subnet in data.azurerm_subnet.this : subnet.name => subnet.id }
}

output "subnet_address_prefixes" {
  description = "Contains a list of the address prefixes of the subnets"
  value       = { for subnet in data.azurerm_subnet.this : subnet.name => subnet.address_prefixes }
}
