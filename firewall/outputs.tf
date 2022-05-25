output "ip" {
  description = "Specifies the ID of the firewall."
  value       = azurerm_firewall.this.id
}

output "private_ip_address" {
  description = "Specifies the private IP address of the firewall."
  value       = azurerm_firewall.this.ip_configuration[0].private_ip_address
}

output "public_ip_addresses_config" {
  description = "Specifies the public IP addresses of the firewall."
  value       = { for pip in azurerm_public_ip.config : pip.name => pip.ip_address }
}

output "public_ip_addresses_managedment" {
  description = "Specifies the managedment public IP addresses of the firewall."
  value       = var.management_subnet_id != null ? { for pip in azurerm_public_ip.managedment : pip.name => pip.ip_address } : null
}

output "policy_name" {
  description = "Specifies the firewall policy name."
  value       = azurerm_firewall_policy.this.name
}

output "policy_id" {
  description = "Specifies the firewall policy id."
  value       = azurerm_firewall_policy.this.id
}

output "ip_configuration_name" {
  description = "Sepcifies the IP configuration."
  value       = { for ip_configuration in azurerm_firewall.this.ip_configuration : ip_configuration.name => ip_configuration.subnet_id }
}

output "ip_configuration_public_ip_address_id" {
  description = "Sepcifies the IP configuration."
  value       = { for ip_configuration in azurerm_firewall.this.ip_configuration : ip_configuration.name => ip_configuration.public_ip_address_id }
}

output "virtual_hub" {
  description = "Specifies the Virtual HUB configuration."
  value       = var.virtual_hub_id != null ? azurerm_firewall.this.virtual_hub : null
}
