resource "random_id" "default" {
  byte_length = 4
}

resource "google_storage_bucket" "public_bucket" {
  name          = "${random_id.default.hex}-dbt-artifact-bucket"
  location      = var.location
  force_destroy = true # optional: delete contents with the bucket

  uniform_bucket_level_access = true

  public_access_prevention = "inherited"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
  depends_on = [google_project_service.storage]
}

# Allow public read access
resource "google_storage_bucket_iam_member" "public_read" {
  count  = var.is_bucket_public ? 1 : 0
  bucket = google_storage_bucket.public_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}