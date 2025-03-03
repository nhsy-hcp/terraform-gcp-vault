# vault

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.22.0 |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 6.22.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.6 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_instance_template"></a> [instance\_template](#module\_instance\_template) | terraform-google-modules/vm/google//modules/instance_template | 13.2.0 |
| <a name="module_kms"></a> [kms](#module\_kms) | terraform-google-modules/kms/google | 4.0.0 |
| <a name="module_mig"></a> [mig](#module\_mig) | terraform-google-modules/vm/google//modules/mig | 13.2.0 |

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_backend_service.nlb_api_external](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_backend_service) | resource |
| [google-beta_google_compute_forwarding_rule.nlb_api](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_forwarding_rule) | resource |
| [google-beta_google_compute_global_forwarding_rule.nlb_api_external](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_global_forwarding_rule) | resource |
| [google-beta_google_compute_region_backend_service.nlb_api](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_region_backend_service) | resource |
| [google-beta_google_compute_target_tcp_proxy.nlb_api_external](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_compute_target_tcp_proxy) | resource |
| [google_compute_address.nlb_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |
| [google_compute_global_address.nlb_api_external](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_health_check.nlb_api_external](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_health_check) | resource |
| [google_compute_region_health_check.nlb_api](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_health_check) | resource |
| [google_compute_security_policy.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_security_policy) | resource |
| [google_dns_managed_zone.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone) | resource |
| [google_dns_record_set.api_external](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_dns_record_set.cluster](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [google_project_iam_member.vault](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.vault](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_storage_bucket_object.ca_cert](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [google_storage_bucket_object.le_ca_cert](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [google_storage_bucket_object.le_vault_cert](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [google_storage_bucket_object.le_vault_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [google_storage_bucket_object.vault_cert](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [google_storage_bucket_object.vault_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [tls_private_key.default](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.vault](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |
| [google_dns_managed_zone.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/dns_managed_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_external_vault_cidrs"></a> [allowed\_external\_vault\_cidrs](#input\_allowed\_external\_vault\_cidrs) | n/a | `list(string)` | `[]` | no |
| <a name="input_ansible_bucket_name"></a> [ansible\_bucket\_name](#input\_ansible\_bucket\_name) | n/a | `string` | n/a | yes |
| <a name="input_create_external_lb"></a> [create\_external\_lb](#input\_create\_external\_lb) | n/a | `bool` | `false` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | Boot disk size in GB | `string` | `"100"` | no |
| <a name="input_enable_cloud_armor"></a> [enable\_cloud\_armor](#input\_enable\_cloud\_armor) | n/a | `bool` | `false` | no |
| <a name="input_fqdn"></a> [fqdn](#input\_fqdn) | n/a | `string` | n/a | yes |
| <a name="input_hostname_prefix"></a> [hostname\_prefix](#input\_hostname\_prefix) | Hostname prefix | `string` | `"vault"` | no |
| <a name="input_https_health_check_request_path"></a> [https\_health\_check\_request\_path](#input\_https\_health\_check\_request\_path) | n/a | `string` | `"/v1/sys/health?sealedcode=200&uninitcode=200"` | no |
| <a name="input_keyring"></a> [keyring](#input\_keyring) | Keyring name. | `string` | n/a | yes |
| <a name="input_keys"></a> [keys](#input\_keys) | Key names. | `list(string)` | <pre>[<br/>  "vault-unseal"<br/>]</pre> | no |
| <a name="input_kms_location"></a> [kms\_location](#input\_kms\_location) | Location for the keyring. | `string` | `"global"` | no |
| <a name="input_letsencrypt_ca"></a> [letsencrypt\_ca](#input\_letsencrypt\_ca) | n/a | `string` | n/a | yes |
| <a name="input_letsencrypt_certificate"></a> [letsencrypt\_certificate](#input\_letsencrypt\_certificate) | n/a | `string` | n/a | yes |
| <a name="input_letsencrypt_private_key"></a> [letsencrypt\_private\_key](#input\_letsencrypt\_private\_key) | n/a | `string` | n/a | yes |
| <a name="input_load_balancing_scheme"></a> [load\_balancing\_scheme](#input\_load\_balancing\_scheme) | n/a | `string` | `"EXTERNAL"` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Machine type for template | `string` | `"n2-standard-2"` | no |
| <a name="input_mig_target_size"></a> [mig\_target\_size](#input\_mig\_target\_size) | n/a | `number` | `3` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Network self link | `string` | n/a | yes |
| <a name="input_network_self_link"></a> [network\_self\_link](#input\_network\_self\_link) | Network self link | `string` | n/a | yes |
| <a name="input_preemptible"></a> [preemptible](#input\_preemptible) | Create preemptive forward proxy instance | `bool` | `false` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project id | `string` | n/a | yes |
| <a name="input_proxy_subnet_name"></a> [proxy\_subnet\_name](#input\_proxy\_subnet\_name) | Proxy subnet name | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region | `string` | n/a | yes |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | Name of service account attached to forward proxy instance | `string` | `null` | no |
| <a name="input_source_image_family"></a> [source\_image\_family](#input\_source\_image\_family) | Source image family for template | `string` | `"ubuntu-2004-lts"` | no |
| <a name="input_source_image_project"></a> [source\_image\_project](#input\_source\_image\_project) | Source image project | `string` | `"ubuntu-os-cloud"` | no |
| <a name="input_subnet_name"></a> [subnet\_name](#input\_subnet\_name) | Subnet name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Firewall tags | `list(string)` | `[]` | no |
| <a name="input_template_name"></a> [template\_name](#input\_template\_name) | Name of template used by mig | `string` | `"vault"` | no |
| <a name="input_tls_domain_name"></a> [tls\_domain\_name](#input\_tls\_domain\_name) | n/a | `string` | `"example.com"` | no |
| <a name="input_tls_organization"></a> [tls\_organization](#input\_tls\_organization) | n/a | `string` | `"ACME"` | no |
| <a name="input_unique_id"></a> [unique\_id](#input\_unique\_id) | n/a | `string` | n/a | yes |
| <a name="input_vault_license"></a> [vault\_license](#input\_vault\_license) | n/a | `string` | `""` | no |
| <a name="input_vault_sa_roles"></a> [vault\_sa\_roles](#input\_vault\_sa\_roles) | n/a | `set(string)` | <pre>[<br/>  "roles/logging.logWriter",<br/>  "roles/monitoring.metricWriter",<br/>  "roles/monitoring.viewer",<br/>  "roles/stackdriver.resourceMetadata.writer",<br/>  "roles/compute.networkViewer",<br/>  "roles/cloudkms.cryptoKeyEncrypterDecrypter",<br/>  "roles/cloudkms.viewer",<br/>  "roles/storage.objectViewer"<br/>]</pre> | no |
| <a name="input_vault_storage_backend"></a> [vault\_storage\_backend](#input\_vault\_storage\_backend) | n/a | `string` | `"integrated"` | no |
| <a name="input_vault_version"></a> [vault\_version](#input\_vault\_version) | n/a | `string` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_compute_sa_email"></a> [compute\_sa\_email](#output\_compute\_sa\_email) | n/a |
| <a name="output_external_ip_address"></a> [external\_ip\_address](#output\_external\_ip\_address) | n/a |
| <a name="output_internal_ip_address"></a> [internal\_ip\_address](#output\_internal\_ip\_address) | n/a |
| <a name="output_mig_instance_group"></a> [mig\_instance\_group](#output\_mig\_instance\_group) | n/a |
| <a name="output_mig_name"></a> [mig\_name](#output\_mig\_name) | n/a |
| <a name="output_mig_self_link"></a> [mig\_self\_link](#output\_mig\_self\_link) | n/a |
| <a name="output_vault_ca_cert"></a> [vault\_ca\_cert](#output\_vault\_ca\_cert) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
