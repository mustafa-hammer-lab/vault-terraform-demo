locals {
  vault_cluster_name = "${var.environment}-vault-cluster"
}
data "hcp_vault_cluster" "vault_cluster" {
  cluster_id = local.vault_cluster_name
}

resource "hcp_vault_cluster_admin_token" "admin_token" {
  cluster_id = data.hcp_vault_cluster.vault_cluster.cluster_id
}

data "vault_namespace" "current" {}

resource "vault_namespace" "namespaces" {
  for_each = var.namespaces

  path = each.value.name
  custom_metadata = {
    "managed_by"  = each.value.managed_by
    "environment" = var.environment
  }
}

# Create admin policy in the root namespace
resource "vault_policy" "admin_policy" {
  name   = "admins"
  policy = file("policies/admin-policy.hcl")
}

# Create admin policy in other namespaces
resource "vault_policy" "admin_namespace_policy" {
  for_each = var.namespaces

  namespace = vault_namespace.namespaces[each.key].path
  name      = "admins"
  policy    = file("policies/admin-policy.hcl")
}


#--------------------------------------------------------------------
# Enable approle auth method
#--------------------------------------------------------------------
resource "vault_auth_backend" "approle" {
  type = "approle"
  path = "admin-approle"
}

# Create a role named, "test-role"
resource "vault_approle_auth_backend_role" "test-role" {
  depends_on     = [vault_auth_backend.approle, vault_policy.admin_policy]
  backend        = vault_auth_backend.approle.path
  role_name      = "test-role"
  token_policies = ["default", "admins"]
}
