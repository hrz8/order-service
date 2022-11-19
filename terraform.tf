terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.42.1"
    }
  }

  cloud {
    hostname = "app.terraform.io"
  }
}

provider "google" {
  project = local.project_id
  region  = local.stages[var.stage].region
}

provider "google-beta" {
  project = local.project_id
  region  = local.stages[var.stage].region
}
