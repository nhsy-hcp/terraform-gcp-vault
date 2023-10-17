resource "google_storage_bucket" "ansible" {
  name          = "ansible-${module.common.unique_id}"
  location      = var.region
  force_destroy = true

  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "files" {
  for_each     = fileset("ansible/", "**")
  bucket       = google_storage_bucket.ansible.name
  name         = each.value
  source       = "ansible/${each.value}"
  content_type = "text/plain"
}