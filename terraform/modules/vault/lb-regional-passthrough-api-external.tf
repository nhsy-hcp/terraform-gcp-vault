resource "google_compute_health_check" "nlb_api_external" {
  count               = var.create_external_lb ? 1 : 0
  name                = "vault-nlb-api-external-hc-${var.unique_id}"
  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 3
  unhealthy_threshold = 3
  https_health_check {
    port         = "8300"
    request_path = var.https_health_check_request_path
  }
  log_config {
    enable = false
  }
}

resource "google_compute_backend_service" "nlb_api_external" {
  count    = var.create_external_lb ? 1 : 0
  provider = google-beta

  name                  = "vault-nlb-api-external-${var.unique_id}"
  protocol              = "TCP"
  load_balancing_scheme = "EXTERNAL"
  timeout_sec           = 10
  health_checks         = [google_compute_health_check.nlb_api_external[0].id]
  port_name             = "vault-api-8300"
  security_policy       = var.enable_cloud_armor ? google_compute_security_policy.default[0].id : null

  log_config {
    enable      = false
    sample_rate = 1.0
  }

  backend {
    group                        = module.mig.instance_group
    balancing_mode               = "CONNECTION"
    capacity_scaler              = 1.0
    max_connections_per_instance = 100
  }
}

resource "google_compute_target_tcp_proxy" "nlb_api_external" {
  count    = var.create_external_lb ? 1 : 0
  provider = google-beta

  name            = "vault-nlb-api-external-${var.unique_id}"
  backend_service = google_compute_backend_service.nlb_api_external[0].id
}

resource "google_compute_global_address" "nlb_api_external" {
  count        = var.create_external_lb ? 1 : 0
  name         = "vault-nlb-api-external-${var.unique_id}"
  address_type = "EXTERNAL"
}

resource "google_compute_global_forwarding_rule" "nlb_api_external" {
  count    = var.create_external_lb ? 1 : 0
  provider = google-beta

  name                  = "vault-nlb-api-external-fr-${var.unique_id}"
  ip_address            = google_compute_global_address.nlb_api_external[0].id
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "443"
  target                = google_compute_target_tcp_proxy.nlb_api_external[0].id
}
