terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.42.1"
    }
  }
}

provider "google" {
  credentials = file("creds.json")
  project     = local.project_id
  region      = local.stages[var.stage].region
}
