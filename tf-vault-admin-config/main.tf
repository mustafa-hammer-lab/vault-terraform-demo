data "hcp_vault_cluster" "example" {
  cluster_id = "prod-vault-cluster"
}

resource "hcp_vault_cluster_admin_token" "example" {
  cluster_id = data.hcp_vault_cluster.example.cluster_id
}
