output "mig_instance_group" {
  value = module.mig.instance_group
}

output "mig_name" {
  value = module.mig.instance_group_manager.name
}

output "mig_self_link" {
  value = module.mig.self_link
}

output "compute_sa_email" {
  value = local.service_account_email
}
