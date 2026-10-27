data "azurerm_client_config" "current" {}

locals {
  github_subjects = {
    main         = "${var.github_subject}:ref:refs/heads/main"
    pull-request = "${var.github_subject}:pull_request" # À COMPLÉTER : pull_request
  }
}

resource "azurerm_resource_group" "main" {
  name     = "rg-${var.prenom}-oidc"
  location = var.location
}

resource "azurerm_user_assigned_identity" "github" {
  name                = "id-${var.prenom}-github"            # À COMPLÉTER : la variable du prénom
  resource_group_name = azurerm_resource_group.main.name     # À COMPLÉTER : le nom du resource group (référence)
  location            = azurerm_resource_group.main.location # À COMPLÉTER : la région du resource group (référence)
}


resource "azurerm_federated_identity_credential" "github" {
  for_each = local.github_subjects

  name                      = "github-${each.key}"
  user_assigned_identity_id = azurerm_user_assigned_identity.github.id
  issuer                    = "https://token.actions.githubusercontent.com"
  audience                  = ["api://AzureADTokenExchange"]
  subject                   = each.value # À COMPLÉTER : la valeur de l'élément courant
}

resource "azurerm_role_assignment" "reader" {
  principal_id         = azurerm_user_assigned_identity.github.principal_id
  role_definition_name = "Lecteur formation"
  scope                = azurerm_resource_group.main.id
}