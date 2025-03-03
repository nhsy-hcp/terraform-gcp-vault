locals {
  fqdn         = format("%s.%s", var.hostname, var.domain_name)
  mgmt_ip_cidr = "${chomp(data.http.mgmt_ip.response_body)}/32"
}

data "http" "mgmt_ip" {
  url = "http://ipv4.icanhazip.com"
  lifecycle {
    postcondition {
      condition     = self.status_code == 200
      error_message = "Failed to get management IP address"
    }
  }
}
