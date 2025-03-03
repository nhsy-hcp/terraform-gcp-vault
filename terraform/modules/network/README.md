# network

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 6.22.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_network.vpc](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_router.router](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router) | resource |
| [google_compute_router_nat.nat](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat) | resource |
| [google_compute_subnetwork.proxy_subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_compute_subnetwork.subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_create_subnetworks"></a> [auto\_create\_subnetworks](#input\_auto\_create\_subnetworks) | When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources | `bool` | `false` | no |
| <a name="input_delete_default_internet_gateway_routes"></a> [delete\_default\_internet\_gateway\_routes](#input\_delete\_default\_internet\_gateway\_routes) | If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | An optional description of this resource. The resource must be recreated to modify this field | `string` | `null` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The name of the network being created | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Identifier of the host project where the VPC will be created | `string` | n/a | yes |
| <a name="input_proxy_subnet"></a> [proxy\_subnet](#input\_proxy\_subnet) | The subnet being created | <pre>object({<br/>    subnet_name                      = string<br/>    subnet_ip                        = string<br/>    subnet_region                    = string<br/>    subnet_private_access            = optional(string, "false")<br/>    subnet_flow_logs                 = optional(string, "false")<br/>    subnet_flow_logs_interval        = optional(string, "INTERVAL_5_SEC")<br/>    subnet_flow_logs_sampling        = optional(string, "0.5")<br/>    subnet_flow_logs_metadata        = optional(string, "INCLUDE_ALL_METADATA")<br/>    subnet_flow_logs_filter          = optional(string, "true")<br/>    subnet_flow_logs_metadata_fields = optional(list(string), [])<br/>    description                      = optional(string)<br/>    purpose                          = optional(string)<br/>    role                             = optional(string)<br/>  })</pre> | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region to deploy to | `string` | n/a | yes |
| <a name="input_router_name"></a> [router\_name](#input\_router\_name) | Router name | `string` | `"cr-nat-router"` | no |
| <a name="input_router_nat_name"></a> [router\_nat\_name](#input\_router\_nat\_name) | Name for the router NAT gateway | `string` | `"rn-nat-gateway"` | no |
| <a name="input_routing_mode"></a> [routing\_mode](#input\_routing\_mode) | The network routing mode | `string` | `"REGIONAL"` | no |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | The subnet being created | <pre>object({<br/>    subnet_name                      = string<br/>    subnet_ip                        = string<br/>    subnet_region                    = string<br/>    subnet_private_access            = optional(string, "false")<br/>    subnet_flow_logs                 = optional(string, "false")<br/>    subnet_flow_logs_interval        = optional(string, "INTERVAL_5_SEC")<br/>    subnet_flow_logs_sampling        = optional(string, "0.5")<br/>    subnet_flow_logs_metadata        = optional(string, "INCLUDE_ALL_METADATA")<br/>    subnet_flow_logs_filter          = optional(string, "true")<br/>    subnet_flow_logs_metadata_fields = optional(list(string), [])<br/>    description                      = optional(string)<br/>    purpose                          = optional(string)<br/>    role                             = optional(string)<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network"></a> [network](#output\_network) | The created network |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | Name of VPC |
| <a name="output_network_self_link"></a> [network\_self\_link](#output\_network\_self\_link) | VPC network self link |
| <a name="output_project"></a> [project](#output\_project) | Project id |
| <a name="output_proxy_subnet"></a> [proxy\_subnet](#output\_proxy\_subnet) | The proxy\_subnet resource |
| <a name="output_proxy_subnet_name"></a> [proxy\_subnet\_name](#output\_proxy\_subnet\_name) | The proxy\_subnet resource |
| <a name="output_subnet"></a> [subnet](#output\_subnet) | The subnet resource |
| <a name="output_subnet_name"></a> [subnet\_name](#output\_subnet\_name) | The name of the subnet |
| <a name="output_subnet_region"></a> [subnet\_region](#output\_subnet\_region) | The region of the subnet |
| <a name="output_subnet_self_links"></a> [subnet\_self\_links](#output\_subnet\_self\_links) | The self\_link of the subnet |
| <a name="output_subnets_ip_cidr_ranges"></a> [subnets\_ip\_cidr\_ranges](#output\_subnets\_ip\_cidr\_ranges) | The IP CIDR of the subnet |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
