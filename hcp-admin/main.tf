locals {
}

resource "hcp_project" "projects" {
  for_each = var.vault_clusters

  name        = each.key
  description = "This is a project for: ${each.key}"
}

resource "hcp_hvn" "hvn" {
  for_each = var.vault_clusters

  hvn_id         = "${each.key}-vault-demo"
  cloud_provider = "aws"
  region         = "us-west-2"
  cidr_block     = each.value.cidr_block
}

resource "hcp_vault_cluster" "hcp_vault_cluster" {
  for_each = var.vault_clusters

  cluster_id = "${each.key}-vault-cluster"
  hvn_id     = hcp_hvn.hvn[each.key].hvn_id
  tier       = each.value.tier

  lifecycle {
    prevent_destroy = true
  }
}


