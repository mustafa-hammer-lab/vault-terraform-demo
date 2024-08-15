terraform {
  required_version = "~> 1.6"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.0.0"
    }
  }
}

provider "hcp" {
  # Configuration options
}


# Configure the Vault provider
provider "vault" {
  address = data.hcp_vault_cluster.example.public_endpoint
  token   = hcp_vault_cluster_admin_token.example.token
}
