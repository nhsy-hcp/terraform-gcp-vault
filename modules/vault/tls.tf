resource "tls_private_key" "default" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "tls_self_signed_cert" "vault" {
  private_key_pem = tls_private_key.default.private_key_pem

  dns_names = [
    "vault.${var.tls_domain_name}",
    "*.c.${var.project_id}.internal"
  ]

  subject {
    common_name  = "vault.${var.tls_domain_name}"
    organization = var.tls_organization
  }

  validity_period_hours = 24 * 365

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

resource "google_storage_bucket_object" "ca_cert" {
  bucket       = var.ansible_bucket_name
  name         = "tls/ca.pem"
  content      = tls_self_signed_cert.vault.cert_pem
  content_type = "text/plain"
}

resource "google_storage_bucket_object" "vault_cert" {
  bucket       = var.ansible_bucket_name
  name         = "tls/vault.pem"
  content      = tls_self_signed_cert.vault.cert_pem
  content_type = "text/plain"
}

resource "google_storage_bucket_object" "vault_key" {
  bucket       = var.ansible_bucket_name
  name         = "tls/vault.key"
  content      = tls_self_signed_cert.vault.private_key_pem
  content_type = "text/plain"
}
