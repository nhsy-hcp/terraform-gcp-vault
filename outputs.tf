output "region" {
  value = var.region
}
output "unique_id" {
  value = module.common.unique_id
}

# Change vault listener port if not 443
output "vault_url" {
  value = "https://${local.fqdn}"
}

output "mig_name" {
  value = module.vault.mig_name
}
