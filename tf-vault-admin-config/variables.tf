variable "code_repo" {
  type        = string
  description = "The name of the Github repo where the infrastructure is managed."
  default     = "vault-terraform-demo"
}

variable "code_repo_folder" {
  type        = string
  description = "The name of the folder in the Github repo where the infrastructure is managed."
  default     = "tf-vault-admin-config"
}

variable "team" {
  type    = string
  default = "mustafa-rsa"
}

variable "environment" {
  type = string
}

# variable "vault_addr" {
#   type = string
# }

# variable "vault_token" {
#   type = string
# }

variable "namespaces" {
  description = "Map of Vault namespaces with relevant details."
  type = map(object({
    name       = string
    managed_by = string
  }))
}
