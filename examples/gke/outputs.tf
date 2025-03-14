output "gke_cluster_name" {
  value = google_container_cluster.default.name
}

output "gke_dns_endpoint" {
  value = try(google_container_cluster.default.control_plane_endpoints_config[0].dns_endpoint_config[0].endpoint, null)
}

output "gke_endpoint" {
  value = google_container_cluster.default.endpoint
}

output "gke_ca_cert" {
  value = base64decode(google_container_cluster.default.master_auth.0.cluster_ca_certificate)
}

output "region" {
  value = local.region
}

output "bastion_name" {
  value = google_compute_instance.bastion.name
}

output "bastion_zone" {
  value = google_compute_instance.bastion.zone
}
