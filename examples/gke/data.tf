data "google_compute_network" "default" {
  name = local.network_name
}

data "google_compute_subnetwork" "default" {
  name   = local.subnetwork_name
  region = local.region
}

data "terraform_remote_state" "vault" {
  backend = "local"
  config = {
    path = "../../terraform/terraform.tfstate"
  }
}

data "google_compute_zones" "available" {
  region = local.region
  status = "UP"
}

data "http" "external_ip" {
  url = "http://ipv4.icanhazip.com"
  lifecycle {
    postcondition {
      condition     = self.status_code == 200
      error_message = "Failed to get external IP"
    }
  }
}
