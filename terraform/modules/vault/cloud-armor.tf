resource "google_compute_security_policy" "default" {
  count       = var.enable_cloud_armor ? 1 : 0
  name        = "vault-policy-${var.unique_id}"
  description = "Vault security policy"
  type        = "CLOUD_ARMOR"

  dynamic "rule" {
    for_each = var.allowed_external_vault_cidrs
    content {
      action   = "allow"
      priority = 1000 + rule.key
      match {
        versioned_expr = "SRC_IPS_V1"
        config {
          src_ip_ranges = ["${rule.value}"]
        }
      }
      description = "Default rule, higher priority overrides it"
    }
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
