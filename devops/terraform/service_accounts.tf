resource "google_service_account" "default" {
  account_id   = "dbt-ci"
  display_name = "DBT CI Service Account"
}

resource "google_project_iam_member" "artifactregistry_writer" {
  project = var.project
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.default.email}"
}

resource "google_project_iam_member" "log_writer" {
  project = var.project
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.default.email}"
}

resource "google_project_iam_member" "cloudbuild_editor" {
  project = var.project
  role    = "roles/cloudbuild.builds.editor"
  member  = "serviceAccount:${google_service_account.default.email}"
}

resource "google_project_iam_member" "service_account_user" {
  project = var.project
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.default.email}"
}