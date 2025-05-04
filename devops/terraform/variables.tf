variable "project" {
  description = "The name of the GCP project"
  type        = string
}

variable "github_owner" {
  description = "The owner of the GitHub repository where your code is hosted"
  type        = string
}

variable "github_repo" {
  description = "The name of the GitHub repository where your code is hosted"
  type        = string
}

variable "dbt_image" {
  description = "The Docker image to use for the DBT job"
  type        = string
}

variable "dbt_command" {
  description = "The DBT command(s) to execute (separated by ||)"
  type        = string
}

variable "location" {
  description = "The GCP location for the resources"
  type        = string
  default     = "EU"
}

variable "region" {
  description = "The GCP region to deploy resources in"
  type        = string
  default     = "europe-west2"
}

variable "environment" {
  description = "The environment for the deployment (e.g., dev, staging, prod)"
  type        = string
  default     = "prod"
}

variable "dbt_dir" {
  description = "The directory containing the DBT project"
  type        = string
  default     = "dbt"
}

variable "artifact_prefix" {
  description = "The prefix for GCS artifact storage"
  type        = string
  default     = "dbt-artifacts"
}

variable "is_bucket_public" {
  description = "Flag to indicate if the bucket should be public"
  type        = bool
  default     = false
}
