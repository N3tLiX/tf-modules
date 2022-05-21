output "route_table_name" {
  value = azurerm_route_table.this.name
}

output "route_table_id" {
  value = azurerm_route_table.this.id
}

output "routes" {
  description = "Contains a list of the resource id of the subnets"
  value       = azurerm_route_table.this.route
}

