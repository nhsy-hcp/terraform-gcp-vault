resource "google_compute_security_policy" "default" {
  count       = var.enable_cloud_armor ? 1 : 0
  name        = "vault-policy-${var.unique_id}"
  description = "Vault security policy"
  type        = "CLOUD_ARMOR"

  rule {
    action   = "allow"
    priority = "1000"

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = ["*"]
      }
    }

    description = "Default rule, higher priority overrides it"
  }

  # Deny all other traffic
  rule {
    action   = "deny"
    priority = "2147483647"

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = ["*"]
      }
    }

    description = "Deny traffic"
  }
}