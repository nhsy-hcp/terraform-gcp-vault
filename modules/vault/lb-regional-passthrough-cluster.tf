resource "google_compute_region_health_check" "nlb_cluster" {
  name                = "vault-nlb-cluster-hc-${var.unique_id}"
  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 3
  unhealthy_threshold = 5
  https_health_check {
    port         = 8200
    port_name    = "vault"
    request_path = "/v1/sys/health"
  }
  log_config {
    enable = false
  }
}

resource "google_compute_region_backend_service" "nlb_cluster" {
  provider = google-beta

  name                  = "vault-nlb-cluster-${var.unique_id}"
  region                = var.region
  protocol              = "TCP"
  load_balancing_scheme = "INTERNAL"
  timeout_sec           = 10
  health_checks         = [google_compute_region_health_check.nlb_cluster.id]

  log_config {
    enable      = true
    sample_rate = 1.0
  }

  backend {
    group          = module.mig.instance_group
    balancing_mode = "CONNECTION"
  }
}

resource "google_compute_address" "nlb_cluster" {
  name         = "vault-nlb-cluster-${var.unique_id}"
  address_type = "INTERNAL"
  subnetwork   = var.subnet_name
}

resource "google_compute_forwarding_rule" "nlb_cluster" {
  provider = google-beta

  name                  = "vault-nlb-cluster-fr-${var.unique_id}"
  backend_service       = google_compute_region_backend_service.nlb_cluster.id
  ip_address            = google_compute_address.nlb_cluster.id
  ip_protocol           = "TCP"
  load_balancing_scheme = "INTERNAL"
  network               = var.network_name
  subnetwork            = var.subnet_name
  all_ports             = true
}
