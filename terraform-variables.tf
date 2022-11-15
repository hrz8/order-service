locals {
  project_id = "hello-gcp-367807"
  service_name = "order-service"
  service_alias = format("%s-%s", local.service_name, var.stage)

  # gcp set up
  service_account = format("service-invoker@%s.iam.gserviceaccount.com", local.project_id)

  # image setup
  image_name = format("%s:%s", local.service_alias, var.image_version)
  image_registry = format("gcr.io/%s/%s", local.project_id, local.image_name)

  # stage variables
  stages = {
    dev-id = {
      name = "dev-id"
      region = "us-central1"
    }
    dev_sg = {
      name = "dev_sg"
      region = "us-central1"
    }
  }
}
