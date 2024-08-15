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
