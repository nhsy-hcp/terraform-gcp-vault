module "kms" {
  source  = "terraform-google-modules/kms/google"
  version = "4.0.0"

  project_id      = var.project_id
  keyring         = var.keyring
  location        = var.kms_location
  keys            = var.keys
  prevent_destroy = false
}
