terraform {
  required_version = "~> 1.6"
  cloud {
    organization = "mustafa-lab"
    workspaces {
      tags = ["tf-vault-admin-config"]
    }
  }
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">= 4.4.0"
    }
  }
}

provider "hcp" {
  # Configuration options
}


# Configure the Vault provider
provider "vault" {
  # address = var.vault_addr
  # token   = var.vault_token
}
