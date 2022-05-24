output "nsg_name" {
  value = data.azurerm_network_security_group.this.name
}

output "nsg_id" {
  value = data.azurerm_network_security_group.this.id
}
