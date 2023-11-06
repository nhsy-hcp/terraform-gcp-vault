resource "google_compute_region_health_check" "default" {
  name                = "vault-hc-${var.unique_id}"
  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 3
  unhealthy_threshold = 5
  tcp_health_check {
    port      = 8200
    port_name = "vault"
  }
  #  https_health_check {
  #    port         = 8200
  #    port_name    = "vault"
  #    request_path = "/v1/sys/health?perfstandbyok=true"
  #  }
}

resource "google_compute_region_backend_service" "default" {
  provider = google-beta

  name                  = "vault-lb-${var.unique_id}"
  region                = var.region
  protocol              = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  timeout_sec           = 10
  health_checks         = [google_compute_region_health_check.default.id]

  log_config {
    enable      = true
    sample_rate = 1.0
  }

  backend {
    group = module.mig.instance_group
    #    balancing_mode  = "CONNECTION"
    balancing_mode               = "UTILIZATION"
    capacity_scaler              = 1.0
    max_connections_per_instance = 100
    max_utilization              = 0.8
  }
}

resource "google_compute_address" "default" {
  name         = "vault-lb-${var.unique_id}"
  network_tier = "STANDARD"
}

resource "google_compute_region_target_tcp_proxy" "default" {
  provider = google-beta

  name            = "vault-proxy-${var.unique_id}"
  backend_service = google_compute_region_backend_service.default.id
  proxy_header    = "NONE"

}

resource "google_compute_forwarding_rule" "default" {
  provider = google-beta

  name = "vault-fr-${var.unique_id}"
  #  backend_service = google_compute_region_backend_service.default.id
  ip_address            = google_compute_address.default.id
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  network               = var.network_name
  network_tier          = "STANDARD"
  port_range            = 443
  target                = google_compute_region_target_tcp_proxy.default.id
}
