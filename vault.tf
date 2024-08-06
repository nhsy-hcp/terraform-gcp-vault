module "vault" {
  source = "./modules/vault"

  fqdn                    = local.fqdn
  network_name            = module.network.network_name
  project_id              = var.project_id
  region                  = var.region
  subnet_name             = module.network.subnet_name
  proxy_subnet_name       = module.network.proxy_subnet_name
  tags                    = ["iap", "vault"]
  unique_id               = module.common.unique_id
  zone                    = module.common.zone
  keyring                 = format("vault-%s", module.common.unique_id)
  ansible_bucket_name     = google_storage_bucket.ansible.name
  tls_domain_name         = var.domain_name
  mig_target_size         = var.mig_target_size
  disk_size_gb            = var.disk_size_gb
  vault_license           = var.vault_license
  vault_storage_backend   = var.vault_storage_backend
  vault_version           = var.vault_version
  letsencrypt_ca          = acme_certificate.default.issuer_pem
  letsencrypt_certificate = "${acme_certificate.default.certificate_pem}${acme_certificate.default.issuer_pem}"
  letsencrypt_private_key = acme_certificate.default.private_key_pem
  machine_type            = var.machine_type

  depends_on = [
    google_project_service.apis,
    module.network
  ]
}
