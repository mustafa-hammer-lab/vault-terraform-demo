locals {
}

data "hcp_project" "project" {
  project = "f1e1f94a-ee7d-4459-bcf3-777c402d81ab"
}

resource "hcp_hvn" "hvn" {
  for_each = var.vault_clusters

  project_id     = data.hcp_project.project.resource_id
  hvn_id         = "${each.key}-vault-demo"
  cloud_provider = "aws"
  region         = "us-west-2"
  cidr_block     = each.value.cidr_block
}

resource "hcp_vault_cluster" "hcp_vault_cluster" {
  for_each = var.vault_clusters

  project_id = data.hcp_project.project.resource_id
  cluster_id = "${each.key}-vault-cluster"
  hvn_id     = hcp_hvn.hvn[each.key].hvn_id
  tier       = each.value.tier

  public_endpoint = true

  lifecycle {
    prevent_destroy = false
  }
}

resource "hcp_vault_cluster_admin_token" "admin_token" {
  for_each   = var.vault_clusters
  cluster_id = hcp_vault_cluster.hcp_vault_cluster[each.key].cluster_id
}

output "tokens" {
  description = "The admin tokens for Vault"
  value = {
    for cluster, _ in var.vault_clusters : cluster => nonsensitive(hcp_vault_cluster_admin_token.admin_token[cluster].token)
  }
}

output "vault_public_endpoints" {
  description = "The public endpoints for dev and prod Vault clusters"
  value = {
    for cluster, _ in var.vault_clusters : cluster => hcp_vault_cluster.hcp_vault_cluster[cluster].vault_public_endpoint_url
  }
}

data "tfe_organization" "org" {
  name = "mustafa-lab"
}

resource "tfe_project" "vault_project" {
  for_each = var.vault_clusters

  organization = data.tfe_organization.org.name
  name         = "${each.key}-vault"
}

resource "tfe_variable_set" "vault_variable_set" {
  for_each = var.vault_clusters

  name         = "${each.key}-vault-tokens"
  organization = data.tfe_organization.org.name
}

resource "tfe_project_variable_set" "vault_project_variable_set" {
  for_each = var.vault_clusters

  project_id      = tfe_project.vault_project[each.key].id
  variable_set_id = tfe_variable_set.vault_variable_set[each.key].id
}

resource "tfe_variable" "vault_url" {
  for_each = var.vault_clusters

  key             = "VAULT_ADDR"
  value           = hcp_vault_cluster.hcp_vault_cluster[each.key].vault_public_endpoint_url
  category        = "env"
  sensitive       = true
  variable_set_id = tfe_variable_set.vault_variable_set[each.key].id
}

resource "tfe_variable" "vault_token" {
  for_each = var.vault_clusters

  key             = "VAULT_TOKEN"
  value           = hcp_vault_cluster_admin_token.admin_token[each.key].token
  category        = "env"
  sensitive       = true
  variable_set_id = tfe_variable_set.vault_variable_set[each.key].id
}
