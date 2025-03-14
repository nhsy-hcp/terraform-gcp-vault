resource "google_compute_instance" "bastion" {
  name         = "bastion-${local.unique_id}"
  machine_type = "e2-medium"
  zone         = data.google_compute_zones.available.names[0]
  tags         = ["bastion", "iap"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network    = local.network_name
    subnetwork = local.subnetwork_name
    access_config {
      // Ephemeral IP
    }
  }
}

# resource "google_compute_firewall" "bastion" {
#   name    = "allow-bastion-ssh"
#   network = local.network_name
#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }
#   source_ranges = ["${chomp(data.http.external_ip.response_body)}/32"]
#   target_tags   = ["bastion"]
# }
