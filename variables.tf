variable "prenom" {
  type        = string
  description = "Votre prénom, en minuscules et sans accent : il préfixe toutes vos ressources."

  validation {
    condition     = can(regex("^[a-z]{2,12}$", var.prenom))
    error_message = "2 à 12 lettres minuscules, sans accent ni tiret."
  }
}

variable "location" {
  type    = string
  default = "swedencentral"
}

variable "github_subject" {
  type        = string
  description = "Début du subject OIDC de votre dépôt, lu dans le log de azure/login : repo:<propriétaire>@<id>/<dépôt>@<id>"

  validation {
    condition     = can(regex("^repo:[^:]+$", var.github_subject))
    error_message = "Format attendu : repo:<propriétaire>@<id>/<dépôt>@<id>, sans :ref ni :pull_request."
  }
}