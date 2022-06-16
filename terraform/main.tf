data "google_project" "project" {
}

resource "google_project_service" "run_api" {
  service            = "run.googleapis.com"
  disable_on_destroy = true
}

resource "google_cloud_run_service" "run_app" {
  name     = "test-api"
  location = var.gcp_region

  metadata {
    annotations = {
      "autoscaling.knative.dev/maxScale" = "10"
      "run.googleapis.com/client-name"   = "terraform"
    }
  }

  template {
    spec {
      containers {
        image = "gcr.io/takehomeproject-tomtar/nestjs-realworld-example-app:latest"

        env {
          name  = "DB_HOST"
          value = var.db_host
        }
        env {
          name  = "DB_PORT"
          value = var.db_port
        }
        env {
          name  = "DB_USER"
          value = var.db_user
        }
        env {
          name  = "DB_NAME"
          value = var.db_name
        }
        env {
          name = "DB_PASS"
          value_from {
            secret_key_ref {
              name = var.db_pass_secret
              key  = "latest"
            }
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  depends_on = [google_project_service.run_api]
}

output "service_url" {
  value = google_cloud_run_service.run_app.status[0].url
}

