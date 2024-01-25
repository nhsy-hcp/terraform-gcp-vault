module "vault" {
  source = "./modules/vault"

  fqdn                  = local.fqdn
  network_name          = module.network.network_name
  project_id            = var.project_id
  region                = var.region
  subnet_name           = module.network.subnet_name
  tags                  = ["iap", "vault"]
  unique_id             = module.common.unique_id
  zone                  = module.common.zone
  proxy_subnetwork_name = local.proxy_subnet_name
  keyring               = format("vault-%s", module.common.unique_id)
  ansible_bucket_name   = google_storage_bucket.ansible.name
  tls_domain_name       = var.domain_name
  mig_target_size       = var.mig_target_size
  vault_license         = var.vault_license
  vault_storage_backend = var.vault_storage_backend
  vault_version         = var.vault_version
  lb_tls_certificate    = "${acme_certificate.default.certificate_pem}${acme_certificate.default.issuer_pem}"
  lb_tls_private_key    = acme_certificate.default.private_key_pem

  depends_on = [google_project_service.apis]
}
