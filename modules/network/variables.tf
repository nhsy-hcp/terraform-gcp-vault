variable "region" {
  description = "The region to deploy to"
  type        = string
}

variable "project_id" {
  description = "Identifier of the host project where the VPC will be created"
  type        = string
}

variable "network_name" {
  description = "The name of the network being created"
  type        = string
}

variable "routing_mode" {
  description = "The network routing mode"
  type        = string
  default     = "REGIONAL"
}

variable "shared_vpc_host" {
  description = "Makes this project a Shared VPC host if 'true'"
  type        = bool
  default     = false
}

variable "auto_create_subnetworks" {
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources"
  type        = bool
  default     = false
}

variable "delete_default_internet_gateway_routes" {
  description = "If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted"
  type        = bool
  default     = false
}

variable "description" {
  description = "An optional description of this resource. The resource must be recreated to modify this field"
  type        = string
  default     = null
}

variable "subnets" {
  description = "The list of subnets being created"
  type        = list(map(string))
}

variable "secondary_ranges" {
  description = "Secondary ranges that will be used in some of the subnets"
  type = map(list(object({
    range_name    = string
    ip_cidr_range = string
  })))
  default = {}
}

variable "routes" {
  description = "List of routes being created in this VPC"
  type        = list(map(string))
  default     = []
}

variable "firewall_custom_rules" {
  description = "List of custom rule definitions"
  type = map(object({
    description          = string
    direction            = string
    action               = string
    ranges               = list(string)
    sources              = list(string)
    targets              = list(string)
    use_service_accounts = bool
    rules = list(object({
      protocol = string
      ports    = list(string)
    }))
    extra_attributes = map(string)
  }))
  default = {}
}

variable "ssh_source_ranges" {
  description = "List of IP CIDR ranges for tag-based SSH rule"
  type        = list(string)
  default     = []
}

variable "ssh_target_tags" {
  description = "List of target tags for tag-based SSH rule"
  default     = null
}

variable "http_source_ranges" {
  description = "List of IP CIDR ranges for tag-based HTTP rule"
  type        = list(string)
  default     = []
}

variable "http_target_tags" {
  description = "List of target tags for tag-based HTTP rule"
  default     = null
}

variable "https_source_ranges" {
  description = "List of IP CIDR ranges for tag-based HTTPS rule"
  type        = list(string)
  default     = []
}

variable "https_target_tags" {
  description = "List of target tags for tag-based HTTPS rule, defaults to https-server"
  type        = list(string)
  default     = null
}

variable "router_name" {
  description = "Router name"
  type        = string
  default     = "cr-nat-router"
}

variable "router_nat_name" {
  description = "Name for the router NAT gateway"
  type        = string
  default     = "rn-nat-gateway"
}
