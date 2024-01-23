resource "google_service_account" "vault" {
  account_id = local.sa_name
}

resource "google_project_iam_member" "vault" {
  for_each = var.vault_sa_roles
  role     = each.value
  member   = "serviceAccount:${google_service_account.vault.email}"
  project  = var.project_id
}