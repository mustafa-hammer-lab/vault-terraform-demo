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
    tier            = string
    cidr_block      = string
    prevent_destroy = bool
  }))
  default = {
    "dev" = {
      tier            = "plus_medium"
      cidr_block      = "172.25.16.0/20"
      prevent_destroy = false
    },
    "prod" = {
      tier            = "plus_large"
      cidr_block      = "172.25.16.1/20"
      prevent_destroy = true
    }
  }
}
