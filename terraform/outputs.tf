output "project_id" {
  value = var.project_id
}

output "region" {
  value = var.region
}

output "unique_id" {
  value = module.common.unique_id
}

# Change vault listener port if not 443
output "vault_addr_external" {
  value = "https://${local.fqdn}"
}

output "vault_addr_internal" {
  value = "https://${local.fqdn}:8200"
}

output "vault_fqdn" {
  value = local.fqdn
}

output "mig_name" {
  value = module.vault.mig_name
}

output "network_name" {
  value = module.network.network_name
}

output "network_self_link" {
  value = module.network.network_self_link
}

output "subnetwork_name" {
  value = module.network.subnet_name
}

output "vault_internal_ip_address" {
  value = module.vault.internal_ip_address
}

output "vault_external_ip_address" {
  value = module.vault.external_ip_address
}

output "vault_ca_cert" {
  value = module.vault.vault_ca_cert
}
