#resource "google_compute_region_health_check" "default" {
#  name                = "vault-hc-${var.unique_id}"
#  check_interval_sec  = 10
#  timeout_sec         = 5
#  healthy_threshold   = 3
#  unhealthy_threshold = 5
#  https_health_check {
#    port         = 8200
#    port_name    = "vault"
#    request_path = "/v1/sys/health?perfstandbyok=true&uninitcode=200&sealedcode=200"
#  }
#  log_config {
#    enable = false
#  }
#}
#
#resource "google_compute_region_backend_service" "default" {
#  provider = google-beta
#
#  name                  = "vault-lb-${var.unique_id}"
#  region                = var.region
#  protocol              = "TCP"
#  load_balancing_scheme = var.load_balancing_scheme
#  timeout_sec           = 10
#  health_checks         = [google_compute_region_health_check.default.id]
#  port_name             = "vault"
#  #  security_policy       = google_compute_security_policy.default.id
#
#  log_config {
#    enable      = true
#    sample_rate = 1.0
#  }
#
#  backend {
#    group          = module.mig.instance_group
#    balancing_mode = "CONNECTION"
#  }
#}
#
#resource "google_compute_address" "default" {
#  name         = "vault-lb-${var.unique_id}"
#  address_type = var.load_balancing_scheme
#}
#
#resource "google_compute_forwarding_rule" "default" {
#  provider = google-beta
#
#  name                  = "vault-fr-${var.unique_id}"
#  backend_service       = google_compute_region_backend_service.default.id
#  ip_address            = google_compute_address.default.id
#  ip_protocol           = "TCP"
#  load_balancing_scheme = var.load_balancing_scheme
#  port_range            = 8200
#}
#
#output "lb_ip_address" {
#  value = google_compute_address.default.address
#}