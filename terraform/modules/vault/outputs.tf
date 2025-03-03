output "mig_instance_group" {
  value = module.mig.instance_group
}

output "mig_name" {
  value = module.mig.instance_group_manager.name
}

output "mig_self_link" {
  value = module.mig.self_link
}

output "compute_sa_email" {
  value = local.service_account_email
}

output "internal_ip_address" {
  value = google_compute_address.nlb_api.address
}

output "external_ip_address" {
  value = try(google_compute_global_address.nlb_api_external[0].address, null)
}

output "vault_ca_cert" {
  value = tls_self_signed_cert.vault.cert_pem
}
