output "region" {
  value = var.region
}
output "unique_id" {
  value = module.common.unique_id
}

output "vault_url" {
  value = "https://vault.${var.domain_name}:8200"
}
