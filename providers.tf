provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

provider "acme" {
  #  Enable staging for testing
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
  #  server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
}