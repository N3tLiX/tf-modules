output "ids" {
  description = "Contains a list of the the identity id of the identities"
  value       = { for identity in azurerm_user_assigned_identity.identity : identity.name => identity.id }
}

output "principal_ids" {
  description = "Contains a list of the the identity principal_id of the identities"
  value       = { for identity in azurerm_user_assigned_identity.identity : identity.name => identity.principal_id }
}

output "client_ids" {
  description = "Contains a list of the the identity client_id  of the identities"
  value       = { for identity in azurerm_user_assigned_identity.identity : identity.name => identity.client_id }
}

