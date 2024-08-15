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


