resource "google_cloudbuild_trigger" "ci" {
  name               = "dbt-ci-trigger"
  description        = "Trigger for dbt CI pipeline"
  disabled           = false
  include_build_logs = "INCLUDE_BUILD_LOGS_WITH_STATUS"
  github {
    owner = var.github_owner
    name  = var.github_repo
    push {
      branch = "^refs/heads/feature/terraform-module$"
    }
  }
  substitutions = {
    _REGION                = var.region
    _ARTIFACT_REGISTRY_URL = "${var.region}-docker.pkg.dev/${var.project}/${google_artifact_registry_repository.default.name}"
  }
  filename = "ci.cloudbuild.yaml"
}