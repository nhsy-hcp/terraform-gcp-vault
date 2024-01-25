locals {
  network_name      = "vpc-${module.common.unique_id}"
  subnet_name       = "snet-${module.common.unique_id}"
  proxy_subnet_name = "proxy-snet-${var.region}"
}

module "network" {
  source = "./modules/network"


  network_name    = local.network_name
  project         = var.project_id
  region          = var.region
  router_name     = format("%s-%s", "cr-nat-router", module.common.unique_id)
  router_nat_name = format("%s-%s", "rn-nat-gateway", module.common.unique_id)
  subnet = {
    subnet_name               = local.subnet_name
    subnet_ip                 = var.subnet_cidr
    subnet_region             = var.region
    subnet_private_access     = "true"
    subnet_flow_logs          = "true"
    subnet_flow_logs_interval = "INTERVAL_10_MIN"
    subnet_flow_logs_sampling = 0.7
    subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "iap" {
  name        = "allow-iap-${module.common.unique_id}"
  network     = module.network.network_self_link
  description = "Allow inbound connections from IAP"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["iap"]
}

resource "google_compute_firewall" "internal" {
  name        = "allow-internal-${module.common.unique_id}"
  network     = module.network.network_self_link
  description = "Allow internal"
  allow {
    ports = [
      "22",
      "80",
      "443",
      "8200",
      "8201",
    ]
    protocol = "tcp"
  }
  allow {
    ports    = []
    protocol = "icmp"
  }
  source_ranges = [var.subnet_cidr]
  target_tags   = ["vault"]
}


resource "google_compute_firewall" "vault" {
  name        = "allow-vault-${module.common.unique_id}"
  network     = module.network.network_self_link
  description = "Allow vault access"

  allow {
    protocol = "tcp"
    ports = [
      "8200",
      "8201"
    ]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["vault"]
}