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
