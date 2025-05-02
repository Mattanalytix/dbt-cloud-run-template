resource "google_artifact_registry_repository" "default" {
  repository_id = "dbt-cloud-run-repo"
  format        = "docker"
  location      = var.region
  description   = "My Docker repository for my dbt application"
  labels = {
    environment = var.environment
    team        = "data"
  }
  lifecycle {
    prevent_destroy = true
  }
  depends_on = [google_project_service.artifact_registry]
}
