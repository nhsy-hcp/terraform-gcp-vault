data "google_dns_managed_zone" "default" {
  name = "doormat-accountid"
}

resource "google_dns_record_set" "api" {
  managed_zone = data.google_dns_managed_zone.default.name
  name         = "${var.fqdn}."
  type         = "A"
  ttl          = 60

  rrdatas = [google_compute_global_address.nlb_api.address]
}

resource "google_dns_record_set" "cluster" {
  managed_zone = data.google_dns_managed_zone.default.name
  name         = "c.${var.fqdn}."
  type         = "A"
  ttl          = 60

  rrdatas = [google_compute_address.nlb_cluster.address]
}