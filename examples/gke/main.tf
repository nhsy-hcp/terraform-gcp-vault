resource "google_service_account" "default" {
  account_id   = "gke-sa"
  display_name = "GKE Service Account"
}

resource "google_project_iam_member" "default" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer",
    "roles/compute.networkViewer",
    "roles/cloudkms.viewer",
    "roles/storage.objectViewer",
  ])
  role    = each.value
  member  = "serviceAccount:${google_service_account.default.email}"
  project = local.project_id
}

resource "google_container_cluster" "default" {
  name                = "gke-${local.unique_id}"
  deletion_protection = false
  location            = local.region
  network             = local.network_name
  subnetwork          = local.subnetwork_name

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  enable_l4_ilb_subsetting  = true
  default_max_pods_per_node = 32

  control_plane_endpoints_config {
    dns_endpoint_config {
      allow_external_traffic = true
    }
  }

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "10.129.0.0/21"
    services_ipv4_cidr_block = "10.130.0.0/21"
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }

  master_authorized_networks_config {
    gcp_public_cidrs_access_enabled = false

    cidr_blocks {
      cidr_block   = data.google_compute_subnetwork.default.ip_cidr_range
      display_name = "snet"
    }
  }
  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "10.128.0.0/28"
  }
  release_channel {
    channel = "REGULAR"
  }
  workload_identity_config {
    workload_pool = "${local.project_id}.svc.id.goog"
  }
}

resource "google_container_node_pool" "default" {
  name       = "node-pool"
  location   = local.region
  cluster    = google_container_cluster.default.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
