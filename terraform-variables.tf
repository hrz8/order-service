locals {
  project_id    = var.project_id
  service_name  = var.service_name
  service_alias = format("%s-%s", local.service_name, var.stage)

  # gcp set up
  service_account = var.service_account

  # image setup
  image_name     = format("%s:%s", local.service_alias, var.image_tag)
  image_registry = format("gcr.io/%s/%s", local.project_id, local.image_name)

  # stage variables
  stages = {
    dev-id = {
      name   = "dev-id"
      region = "us-central1"
    }
    dev-sg = {
      name   = "dev-sg"
      region = "us-central1"
    }
    dev-th = {
      name   = "dev-th"
      region = "us-central1"
    }
    prod-id = {
      name   = "prod-id"
      region = "us-central1"
    }
    prod-sg = {
      name   = "prod-sg"
      region = "us-central1"
    }
    prod-th = {
      name   = "prod-th"
      region = "us-central1"
    }
  }
}
