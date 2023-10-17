output "mig_instance_group" {
  value = module.mig.instance_group
}

output "mig_self_link" {
  value = module.mig.self_link
}

output "compute_sa_email" {
  value = local.service_account_email
}

output "lb_ip_address" {
  value = google_compute_address.default.address
}