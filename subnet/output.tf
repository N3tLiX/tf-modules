#output "names" {
#  description = "Contains a list of the resource name of the subnets"
#  value       = { for subnet in azurerm_subnet.this : subnet.name => subnet.name }
#}

output "names" {
  description = "Contains a list of the resource name of the subnets"
  # value       = toset(azurerm_subnet.this[*].name)
  value = [for subnet in azurerm_subnet.this : subnet.name]
}

output "ids" {
  description = "Contains a list of the resource id of the subnets"
  value       = { for subnet in azurerm_subnet.this : subnet.name => subnet.id }
}

output "address_prefixes" {
  description = "Contains a list of the address prefixes of the subnets"
  value       = { for subnet in azurerm_subnet.this : subnet.name => subnet.address_prefixes }
}
