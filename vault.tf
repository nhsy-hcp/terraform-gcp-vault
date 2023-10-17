module "vault" {
  source = "./modules/vault"

  network_name = module.network.network_name
  project_id   = var.project_id
  region       = var.region
  subnet_name  = module.network.subnets_names[0]
  tags         = ["iap", "vault-node"]
  unique_id    = module.common.unique_id
  zone         = module.common.zone

  source_image_family  = "ubuntu-2004-lts"
  source_image_project = "ubuntu-os-cloud"
  keyring              = format("vault-%s", module.common.unique_id)
  ansible_bucket_name  = google_storage_bucket.ansible.name
  tls_domain_name      = var.domain_name
  mig_target_size      = var.mig_target_size
}
