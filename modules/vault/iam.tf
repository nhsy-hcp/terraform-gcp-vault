module "compute_service_account" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "4.2.1"

  count = var.service_account_name == null ? 1 : 0

  names      = [local.sa_name]
  project_id = var.project_id
}

resource "google_project_iam_member" "vault_sa" {
  for_each = var.compute_sa_roles

  project = var.project_id
  role    = each.value
  member  = local.sa_email_role_format

  depends_on = [module.compute_service_account]
}