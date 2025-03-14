locals {
  network_name    = data.terraform_remote_state.vault.outputs.network_name
  project_id      = data.terraform_remote_state.vault.outputs.project_id
  region          = data.terraform_remote_state.vault.outputs.region
  subnetwork_name = data.terraform_remote_state.vault.outputs.subnetwork_name
  unique_id       = data.terraform_remote_state.vault.outputs.unique_id
}
