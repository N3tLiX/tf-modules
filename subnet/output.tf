# output "names" {
#   description = "Contains a list of the resource name of the subnets"
#   #value       = { for subnet in azurerm_subnet.this : subnet.name => subnet.name }
#   value = for_each azurerm_subnet.this[*].name
# }

output "names" {
  description = "Contains a list of the resource name of the subnets"
  value = for_each = map(
    "name", azurerm_subnet.this[each.key].name
  )
}

output "ids" {
  description = "Contains a list of the resource id of the subnets"
  value       = { for subnet in azurerm_subnet.this : subnet.name => subnet.id }
}

output "address_prefixes" {
  description = "Contains a list of the address prefixes of the subnets"
  value       = { for subnet in azurerm_subnet.this : subnet.name => subnet.address_prefixes }
}
