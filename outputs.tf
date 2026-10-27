output "github_variables" {
  description = "À créer comme variables (pas des secrets) du dépôt GitHub"
  value = {
    AZURE_CLIENT_ID       = azurerm_user_assigned_identity.github.client_id
    AZURE_TENANT_ID       = data.azurerm_client_config.current.tenant_id
    AZURE_SUBSCRIPTION_ID = data.azurerm_client_config.current.subscription_id
    RESOURCE_GROUP        = azurerm_resource_group.main.name
  }
}