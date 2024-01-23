resource "google_compute_security_policy" "default" {
  name        = "vault-policy-${var.unique_id}"
  description = "Vault security policy"
  type        = "CLOUD_ARMOR"

  rule {
    action   = "allow"
    priority = "2147483647"

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = ["*"]
      }
    }

    description = "Default rule, higher priority overrides it"
  }

  # Blacklist traffic from certain ip address cidrs
  rule {
    action   = "deny(403)"
    priority = "1000"

    match {
      versioned_expr = "SRC_IPS_V1"

      config {
        src_ip_ranges = var.cloud_armor_blacklist_cidrs
      }
    }

    description = "Deny traffic from blacklisted cidr ranges"
  }
}