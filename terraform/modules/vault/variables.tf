variable "hostname_prefix" {
  description = "Hostname prefix"
  type        = string
  default     = "vault"
}

variable "machine_type" {
  description = "Machine type for template"
  type        = string
  default     = "n2-standard-2"
}

variable "network_name" {
  description = "Network self link"
  type        = string
}

variable "network_self_link" {
  description = "Network self link"
  type        = string
}

variable "preemptible" {
  description = "Create preemptive forward proxy instance"
  type        = bool
  default     = false
}

variable "project_id" {
  description = "Project id"
  type        = string
}

variable "region" {
  description = "Region"
  type        = string
}

variable "service_account_name" {
  description = "Name of service account attached to forward proxy instance"
  type        = string
  default     = null
}

variable "source_image_family" {
  description = "Source image family for template"
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "source_image_project" {
  description = "Source image project"
  type        = string
  default     = "ubuntu-os-cloud"
}

variable "proxy_subnet_name" {
  description = "Proxy subnet name"
  type        = string
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "tags" {
  description = "Firewall tags"
  type        = list(string)
  default     = []
}

variable "template_name" {
  description = "Name of template used by mig"
  type        = string
  default     = "vault"
}

variable "disk_size_gb" {
  description = "Boot disk size in GB"
  type        = string
  default     = "100"
}

variable "vault_storage_backend" {
  type    = string
  default = "integrated"
  validation {
    condition     = contains(["file", "integrated"], var.vault_storage_backend)
    error_message = "Valid values: file, integrated"
  }
}

variable "unique_id" {
  type = string
}

variable "zone" {
  type = string
}

variable "vault_sa_roles" {
  type = set(string)
  default = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer",
    "roles/compute.networkViewer",
    "roles/cloudkms.cryptoKeyEncrypterDecrypter",
    "roles/cloudkms.viewer",
    "roles/storage.objectViewer",
  ]
}

variable "mig_target_size" {
  type    = number
  default = 3
}

variable "ansible_bucket_name" {
  type = string
}

###
# KMS variables
###

variable "kms_location" {
  description = "Location for the keyring."
  type        = string
  default     = "global"
}

variable "keyring" {
  description = "Keyring name."
  type        = string
}

variable "keys" {
  description = "Key names."
  type        = list(string)
  default     = ["vault-unseal"]
}


###
# TLS variables
###

variable "fqdn" {
  type = string
}

variable "tls_domain_name" {
  type    = string
  default = "example.com"
}

variable "tls_organization" {
  type    = string
  default = "ACME"
}
variable "vault_license" {
  type    = string
  default = ""
}

variable "vault_version" {
  type = string
}

variable "load_balancing_scheme" {
  type    = string
  default = "EXTERNAL"
}

variable "letsencrypt_ca" {
  type = string
}

variable "letsencrypt_certificate" {
  type = string
}

variable "letsencrypt_private_key" {
  type = string
}

variable "https_health_check_request_path" {
  type    = string
  default = "/v1/sys/health?sealedcode=200&uninitcode=200"
}

variable "enable_cloud_armor" {
  type    = bool
  default = false
}

variable "create_external_lb" {
  type    = bool
  default = false
}

variable "allowed_external_vault_cidrs" {
  type    = list(string)
  default = []
}
