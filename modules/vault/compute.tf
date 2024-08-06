module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "10.1.1"

  disk_size_gb         = var.disk_size_gb
  machine_type         = var.machine_type
  name_prefix          = var.template_name
  preemptible          = var.preemptible
  service_account      = local.service_account_object
  source_image_family  = var.source_image_family
  source_image_project = var.source_image_project
  startup_script = templatefile("${path.module}/files/metadata-startup.sh",
    {
      ansible_bucket_name   = var.ansible_bucket_name
      key_ring              = module.kms.keyring_name
      crypto_key            = var.keys[0]
      project_id            = var.project_id
      kms_location          = var.kms_location
      region                = var.region
      namespace             = "vault-${var.unique_id}"
      vault_license         = var.vault_license
      vault_storage_backend = var.vault_storage_backend
      vault_version         = var.vault_version
  })
  subnetwork         = var.subnet_name
  subnetwork_project = var.project_id
  tags               = var.tags
}

module "mig" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "10.1.1"

  region              = var.region
  autoscaling_enabled = false
  target_size         = var.mig_target_size
  hostname            = "vault-${var.unique_id}"
  instance_template   = module.instance_template.self_link
  named_ports = [
    {
      name = "vault-api-8200"
      port = 8200
    },
    {
      name = "vault-api-8300"
      port = 8300 # 2nd API listener with LetsEncrypt certs
    }
  ]
}