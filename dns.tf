data "google_dns_managed_zone" "default" {
  name = "doormat-accountid"
}

resource "google_dns_record_set" "default" {
  managed_zone = data.google_dns_managed_zone.default.name
  name         = "vault.${var.domain_name}."
  type         = "A"
  ttl          = 60

  rrdatas = [module.vault.lb_ip_address]
}
