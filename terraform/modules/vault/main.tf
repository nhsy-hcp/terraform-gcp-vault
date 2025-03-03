locals {
  sa_email_role_format   = format("%s:%s@%s.%s", "serviceAccount", local.sa_name, var.project_id, "iam.gserviceaccount.com")
  sa_name                = var.service_account_name == null ? "vault-compute-${var.unique_id}" : var.service_account_name
  service_account_email  = format("%s@%s.%s", local.sa_name, var.project_id, "iam.gserviceaccount.com")
  service_account_object = { email = google_service_account.vault.email, scopes = ["cloud-platform"] }
}
