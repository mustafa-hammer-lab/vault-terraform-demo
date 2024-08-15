terraform {
  required_version = "~> 1.6"

  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.94.1"
    }
  }
}

provider "hcp" {
  # Configuration options
}

