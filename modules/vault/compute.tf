module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "10.1.0"

  disk_size_gb         = var.disk_size_gb
  machine_type         = var.machine_type
  name_prefix          = var.template_name
  preemptible          = var.preemptible
  service_account      = local.service_account_object
  source_image_family  = var.source_image_family
  source_image_project = var.source_image_project
  startup_script = templatefile("${path.module}/files/metadata-startup.sh",
    {
      ansible_bucket_name = var.ansible_bucket_name
      key_ring            = module.kms.keyring_name
      crypto_key          = var.keys[0]
      project_id          = var.project_id
      kms_location        = var.kms_location
      region              = var.region
      namespace           = "vault-${var.unique_id}"
      vault_license       = var.vault_license
      vault_version       = var.vault_version
  })
  subnetwork         = var.subnet_name
  subnetwork_project = var.project_id
  tags               = var.tags

  #  depends_on = [module.compute_service_account]
}

#module "compute_instance" {
#  source  = "terraform-google-modules/vm/google//modules/compute_instance"
#  version = "10.1.0"
#
#  hostname           = format("%s-%s", var.hostname_prefix, var.unique_id)
#  instance_template  = module.instance_template.self_link
#  subnetwork         = var.subnet_name
#  subnetwork_project = var.project_id
#  num_instances      = 3
#  zone               = var.zone
#
#  depends_on = [module.compute_service_account]
#}

module "mig" {
  source  = "terraform-google-modules/vm/google//modules/mig"
  version = "10.1.0"

  region              = var.region
  autoscaling_enabled = false
  target_size         = var.mig_target_size
  hostname            = "vault-${var.unique_id}"
  instance_template   = module.instance_template.self_link
  named_ports = [{
    name = "vault"
    port = 8200
  }]

  #  depends_on = [module.compute_service_account]
}