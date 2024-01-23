#resource "google_compute_health_check" "default" {
#  name                = "vault-lb-${var.unique_id}"
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
#resource "google_compute_backend_service" "default" {
#  provider = google-beta
#
#  name = "vault-lb-${var.unique_id}"
#  #  load_balancing_scheme = "EXTERNAL_MANAGED"
#  health_checks   = [google_compute_health_check.default.id]
#  port_name       = "vault"
#  protocol        = "TCP"
#  security_policy = google_compute_security_policy.default.id
#  timeout_sec     = 10
#
#  log_config {
#    enable      = true
#    sample_rate = 1.0
#  }
#
#  backend {
#    group                        = module.mig.instance_group
#    balancing_mode               = "UTILIZATION"
#    capacity_scaler              = 1.0
#    max_connections_per_instance = 100
#    max_utilization              = 0.8
#  }
#}
#
#resource "google_compute_global_address" "default" {
#  name = "vault-lb-${var.unique_id}"
#}
#
#resource "google_compute_target_tcp_proxy" "default" {
#  provider = google-beta
#
#  name            = "vault-lb-${var.unique_id}"
#  backend_service = google_compute_backend_service.default.id
#}
#
#resource "google_compute_global_forwarding_rule" "default" {
#  provider = google-beta
#
#  name        = "vault-lb-${var.unique_id}"
#  ip_address  = google_compute_global_address.default.id
#  ip_protocol = "TCP"
#  #  load_balancing_scheme = "EXTERNAL_MANAGED"
#  port_range = 443
#  target     = google_compute_target_tcp_proxy.default.id
#}
#
#output "lb_ip_address" {
#  value = google_compute_global_address.default.address
#}