# terraform

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.2.0 |
| <a name="requirement_acme"></a> [acme](#requirement\_acme) | ~> 2.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6.22.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | ~> 6.22.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | ~> 3.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 1.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_acme"></a> [acme](#provider\_acme) | 2.30.1 |
| <a name="provider_google"></a> [google](#provider\_google) | 6.22.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.4.5 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.6 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_common"></a> [common](#module\_common) | ./modules/common | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./modules/network | n/a |
| <a name="module_vault"></a> [vault](#module\_vault) | ./modules/vault | n/a |

## Resources

| Name | Type |
|------|------|
| [acme_certificate.default](https://registry.terraform.io/providers/vancluever/acme/latest/docs/resources/certificate) | resource |
| [acme_registration.default](https://registry.terraform.io/providers/vancluever/acme/latest/docs/resources/registration) | resource |
| [google_compute_firewall.iap](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.internal](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.vault_nlb](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_project_metadata.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_metadata) | resource |
| [google_project_service.apis](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_storage_bucket.ansible](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_object.files](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [tls_private_key.default](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [google_compute_lb_ip_ranges.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_lb_ip_ranges) | data source |
| [http_http.mgmt_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_vault_cidrs"></a> [allowed\_vault\_cidrs](#input\_allowed\_vault\_cidrs) | n/a | `list(string)` | `[]` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | n/a | `number` | `null` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `string` | n/a | yes |
| <a name="input_enable_cloud_armor"></a> [enable\_cloud\_armor](#input\_enable\_cloud\_armor) | n/a | `bool` | `true` | no |
| <a name="input_google_apis"></a> [google\_apis](#input\_google\_apis) | n/a | `set(string)` | <pre>[<br/>  "cloudkms.googleapis.com",<br/>  "compute.googleapis.com",<br/>  "iap.googleapis.com"<br/>]</pre> | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | n/a | `string` | `"vault"` | no |
| <a name="input_letsencrypt_email"></a> [letsencrypt\_email](#input\_letsencrypt\_email) | n/a | `string` | `"nobody@example.com"` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | n/a | `string` | `null` | no |
| <a name="input_mig_target_size"></a> [mig\_target\_size](#input\_mig\_target\_size) | n/a | `number` | `3` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID to deploy into | `string` | n/a | yes |
| <a name="input_proxy_subnet_cidr"></a> [proxy\_subnet\_cidr](#input\_proxy\_subnet\_cidr) | n/a | `string` | `"10.65.0.0/16"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to deploy to | `string` | `"europe-west1"` | no |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | n/a | `string` | `"10.64.0.0/16"` | no |
| <a name="input_vault_license"></a> [vault\_license](#input\_vault\_license) | n/a | `string` | `""` | no |
| <a name="input_vault_storage_backend"></a> [vault\_storage\_backend](#input\_vault\_storage\_backend) | n/a | `string` | `"integrated"` | no |
| <a name="input_vault_version"></a> [vault\_version](#input\_vault\_version) | n/a | `string` | `"1.15.4"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_mig_name"></a> [mig\_name](#output\_mig\_name) | n/a |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | n/a |
| <a name="output_network_self_link"></a> [network\_self\_link](#output\_network\_self\_link) | n/a |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | n/a |
| <a name="output_region"></a> [region](#output\_region) | n/a |
| <a name="output_subnetwork_name"></a> [subnetwork\_name](#output\_subnetwork\_name) | n/a |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | n/a |
| <a name="output_vault_addr_external"></a> [vault\_addr\_external](#output\_vault\_addr\_external) | Change vault listener port if not 443 |
| <a name="output_vault_addr_internal"></a> [vault\_addr\_internal](#output\_vault\_addr\_internal) | n/a |
| <a name="output_vault_ca_cert"></a> [vault\_ca\_cert](#output\_vault\_ca\_cert) | n/a |
| <a name="output_vault_external_ip_address"></a> [vault\_external\_ip\_address](#output\_vault\_external\_ip\_address) | n/a |
| <a name="output_vault_fqdn"></a> [vault\_fqdn](#output\_vault\_fqdn) | n/a |
| <a name="output_vault_internal_ip_address"></a> [vault\_internal\_ip\_address](#output\_vault\_internal\_ip\_address) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
