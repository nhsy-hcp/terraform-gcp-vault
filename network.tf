locals {
  subnet_name = "snet-${var.region}"
}

module "network" {
  source = "./modules/network"

  firewall_custom_rules = {
    "allow-internal-mgmt-${module.common.unique_id}" : {
      "action" : "allow",
      "description" : "Allow internal mgmt",
      "direction" : "INGRESS",
      "extra_attributes" : {},
      "ranges" : [
        var.subnet_cidr
      ],
      "rules" : [
        {
          ports : [
            "22",
            "80",
            "443",
            "3389",
            "8080",
            "8200",
            "8201",
            "8443",
          ]
          protocol : "tcp"
        },
        {
          ports : null
          protocol : "icmp"
        },
      ],
      "sources" : null
      "targets" : null
      "use_service_accounts" : false
    },
    "allow-iap-${module.common.unique_id}" : {
      "action" : "allow",
      "description" : "Allow inbound connections from IAP",
      "direction" : "INGRESS",
      "extra_attributes" : {},
      "ranges" : [
        "35.235.240.0/20"
      ],
      "rules" : [
        {
          ports : ["22"],
          protocol : "tcp"
        },
        {
          ports : ["8080"],
          protocol : "tcp"
        }
      ],
      "sources" : null,
      "targets" : ["iap"],
      "use_service_accounts" : false
    }
    "allow-external-vault-${module.common.unique_id}" : {
      "action" : "allow",
      "description" : "Allow external vault",
      "direction" : "INGRESS",
      "extra_attributes" : {},
      "ranges" : [
        "0.0.0.0/0"
      ],
      "rules" : [
        {
          ports : [
            "8200",
          ]
          protocol : "tcp"
        },
      ],
      "sources" : null
      "targets" : null
      "use_service_accounts" : false
    },
  }

  network_name    = format("%s-%s", "vpc", module.common.unique_id)
  project_id      = var.project_id
  region          = var.region
  router_name     = format("%s-%s", "cr-nat-router", module.common.unique_id)
  router_nat_name = format("%s-%s", "rn-nat-gateway", module.common.unique_id)
  subnets = [
    {
      subnet_name               = local.subnet_name
      subnet_ip                 = var.subnet_cidr
      subnet_region             = var.region
      subnet_private_access     = "true"
      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling = 0.7
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
    }
  ]
}
