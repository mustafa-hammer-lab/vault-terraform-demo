# resource "vault_mount" "kvv2" {
#   namespace = "all_consumers"
#   path      = "test1-kv"
#   type      = "kv-v2"
# }

# resource "vault_kv_secret_v2" "example" {
#   namespace           = "all_consumers"
#   mount               = vault_mount.kvv2.path
#   name                = "secret"
#   cas                 = 1
#   delete_all_versions = true
#   data_json = jsonencode(
#     {
#       zip = "zap",
#       foo = "bar"
#     }
#   )
#   custom_metadata {
#     max_versions = 5
#     data = {
#       foo = "vault@example.com",
#       bar = "12345"
#     }
#   }
# }

# module "test" {
#   source  = "app.terraform.io/mustafa-lab/manageconsumers/vault"
#   version = "1.0.0"

#   owner_email = "test"
#   namespace   = "all_consumers"
#   #   team_name    = "lala"
#   #   github_token = "dsafkljhdas"
#   #   charge_back  = "dafkj"
# }
