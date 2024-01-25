variable "project_id" {
  description = "Project ID to deploy into"
  type        = string
}

variable "region" {
  description = "The region to deploy to"
  default     = "europe-west1"
  type        = string

  validation {
    condition     = can(regex("(europe-west1|europe-west2|us-central1)", var.region))
    error_message = "The region must be one of: europe-west1, europe-west2, us-central1."
  }
}

variable "subnet_cidr" {
  type    = string
  default = "10.64.0.0/16"
}

variable "proxy_subnet_cidr" {
  type    = string
  default = "10.65.0.0/16"
}


variable "google_apis" {
  type = set(string)
  default = [
    "cloudkms.googleapis.com",
    "compute.googleapis.com",
    "iap.googleapis.com",
  ]
}

variable "domain_name" {
  type = string
}

variable "mig_target_size" {
  type    = number
  default = 3
}

variable "vault_license" {
  type    = string
  default = ""
}

variable "vault_version" {
  type    = string
  default = "1.15.4"
}

variable "vault_storage_backend" {
  type    = string
  default = "integrated"
}

variable "hostname" {
  type    = string
  default = "vault"
}

variable "letsencrypt_email" {
  type    = string
  default = "nobody@example.com"
}
