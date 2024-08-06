resource "google_compute_region_health_check" "nlb_api" {
  name                = "vault-nlb-api-hc-${var.unique_id}"
  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 3
  unhealthy_threshold = 5
  https_health_check {
    port         = "8200"
    request_path = var.https_health_check_request_path
  }
  log_config {
    enable = false
  }
}

resource "google_compute_region_backend_service" "nlb_api" {
  provider = google-beta

  name                  = "vault-nlb-api-${var.unique_id}"
  region                = var.region
  protocol              = "TCP"
  load_balancing_scheme = "INTERNAL"
  timeout_sec           = 10
  health_checks         = [google_compute_region_health_check.nlb_api.id]

  log_config {
    enable      = false
    sample_rate = 1.0
  }

  backend {
    group          = module.mig.instance_group
    balancing_mode = "CONNECTION"
  }
}

resource "google_compute_address" "nlb_api" {
  name         = "vault-nlb-api-${var.unique_id}"
  address_type = "INTERNAL"
  subnetwork   = var.subnet_name
}

resource "google_compute_forwarding_rule" "nlb_api" {
  provider = google-beta

  name                  = "vault-nlb-api-fr-${var.unique_id}"
  backend_service       = google_compute_region_backend_service.nlb_api.id
  ip_address            = google_compute_address.nlb_api.id
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL"
  network               = var.network_name
  subnetwork            = var.subnet_name
  ports                 = ["8200"]
}
