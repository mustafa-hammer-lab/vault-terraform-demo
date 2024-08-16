terraform {
  required_version = "~> 1.6"

  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.94.1"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.58.0"
    }
  }
}

provider "hcp" {
  # Configuration options
}

provider "tfe" {
  # Configuration options
}
