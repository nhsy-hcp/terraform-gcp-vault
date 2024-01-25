locals {
  fqdn = format("%s.%s", var.hostname, var.domain_name)
}