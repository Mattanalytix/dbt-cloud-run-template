resource "google_cloud_run_v2_job" "dbt_job" {
  name     = "dbt-job-${var.environment}"
  location = var.region
  project  = var.project

  template {
    
    template {
      service_account = google_service_account.dbt_service_account.email
      max_retries     = 2

      containers {
        image = var.dbt_image

        env {
          name  = "DBT_COMMAND"
          value = var.dbt_command
        }

        env {
          name  = "ARTIFACT_BUCKET"
          value = google_storage_bucket.dbt_artifact_bucket.name
        }

        env {
          name  = "DBT_DIR"
          value = var.dbt_dir
        }

        env {
          name  = "DBT_TARGET"
          value = var.environment
        }

        env {
          name  = "ARTIFACT_PREFIX"
          value = var.artifact_prefix
        }
      }
    }
  }

  depends_on = [
    google_project_service.artifact_registry,
    google_project_service.storage,
    google_project_service.cloudbuild,
    google_project_service.cloudrun,
    google_project_service.bigquery
  ]
}

output "dbt_job_name" {
  value = google_cloud_run_v2_job.dbt_job.name
}

output "dbt_job_location" {
  value = google_cloud_run_v2_job.dbt_job.location
}