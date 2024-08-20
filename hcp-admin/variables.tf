variable "code_repo" {
  type        = string
  description = "The name of the Github repo where the infrastructure is managed."
  default     = "vault-terraform-demo"
}

variable "code_repo_folder" {
  type        = string
  description = "The name of the folder in the Github repo where the infrastructure is managed."
  default     = "hcp-admin"
}

variable "team" {
  type    = string
  default = "mustafa-rsa"
}

variable "vault_clusters" {
  description = "Map of Vault clusters with relevant details."
  type = map(object({
    tier       = string
    cidr_block = string
  }))
  default = {
    "dev" = {
      tier       = "plus_medium"
      cidr_block = "172.25.16.0/24"
    },
    "prod" = {
      tier       = "plus_small"
      cidr_block = "172.25.17.0/24"
    }
    "test" = {
      tier       = "plus_small"
      cidr_block = "172.25.18.0/24"
    }
  }
}
