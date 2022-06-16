terraform {
  required_version = ">= 1.0.2"

  required_providers {
    google = "4.24"
  }

  backend "gcs" {
    bucket  = "tf-state-takehomeproject"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}