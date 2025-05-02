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

variable "is_bucket_public" {
  description = "Flag to indicate if the bucket should be public"
  type        = bool
  default     = false
}
