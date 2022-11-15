resource "google_cloud_run_service" "service" {
  name     = local.service_alias
  location = local.stages[var.stage].region

  template {
    spec {
      service_account_name = local.service_account
      containers {
        image = local.image_registry
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
