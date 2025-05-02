resource "google_cloudbuild_trigger" "ci" {
  name               = "dbt-ci-trigger-tf"
  description        = "Trigger for dbt CI pipeline"
  disabled           = false
#   include_build_logs = "INCLUDE_BUILD_LOGS_WITH_STATUS"
  service_account = google_service_account.default.email
  github {
    owner = var.github_owner
    name  = var.github_repo
    push {
      branch = "^feature/terraform-module$"
      invert_regex = false
    }
  }
  substitutions = {
    _REGION                = "europe-west3"
    _ARTIFACT_REGISTRY_URL = google_artifact_registry_repository.default.id
  }
  filename = "ci.cloudbuild.yaml"
}