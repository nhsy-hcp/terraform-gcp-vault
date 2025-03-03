data "google_dns_managed_zone" "default" {
  name = "doormat-accountid"
}

resource "google_dns_managed_zone" "default" {
  dns_name = data.google_dns_managed_zone.default.dns_name
  name     = "${var.project_id}-private"

  private_visibility_config {
    networks {
      network_url = var.network_self_link
    }
  }
  visibility = "private"
}

resource "google_dns_record_set" "api_external" {
  count        = var.create_external_lb ? 1 : 0
  managed_zone = data.google_dns_managed_zone.default.name
  name         = "${var.fqdn}."
  type         = "A"
  ttl          = 60

  rrdatas = [google_compute_global_address.nlb_api_external[0].address]
}

resource "google_dns_record_set" "cluster" {
  managed_zone = google_dns_managed_zone.default.name
  name         = "${var.fqdn}."
  type         = "A"
  ttl          = 60

  rrdatas = [google_compute_address.nlb_api.address]
}
