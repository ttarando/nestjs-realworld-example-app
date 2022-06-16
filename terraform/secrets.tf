resource "google_project_service" "secrets_manager" {
  service = "secretmanager.googleapis.com"
  //  disable_on_destroy = true
}

data "google_secret_manager_secret_version" "db_pass" {
  secret = var.db_pass_secret
}

resource "google_secret_manager_secret_iam_member" "secret-access" {
  secret_id = data.google_secret_manager_secret_version.db_pass.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"
}
