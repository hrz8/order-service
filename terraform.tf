terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.42.1"
    }
  }

  cloud {
    organization = "hrz8-org"

    workspaces {
      name = "order-service"
    }
  }
}

provider "google" {
  project = local.project_id
  region  = local.stages[var.stage].region
}
