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

  depends_on = [
    google_project_service.run,
    google_project_service.cloudbuild
  ]
}

resource "google_api_gateway_api" "api" {
  provider = google-beta
  api_id   = format("%s-api-gw", local.service_alias)

  depends_on = [
    google_project_service.apigateway,
    google_project_service.servicemanagement,
    google_project_service.servicecontrol,
    google_cloud_run_service.service
  ]
}

resource "google_api_gateway_api_config" "api_cfg" {
  provider      = google-beta
  api           = google_api_gateway_api.api.api_id
  api_config_id = format("%s-api-gw-cfg", local.service_alias)

  openapi_documents {
    document {
      path = "spec.yaml"
      contents = base64encode(<<-EOF
        swagger: '2.0'
        info:
          title: ${format("%s-api-gw", local.service_alias)}
          description: 'Endpoint documentation of ${local.service_name}'
          version: '1.0.0'
        produces:
          - application/json
        x-google-backend:
          address: ${google_cloud_run_service.service.status[0].url}
        basePath: /api/v1
        paths:
          '/ping':
            get:
              summary: Ping the server
              description: 'Ping the server 🚀'
              operationId: ping
              responses:
                200:
                  description: OK
                  schema:
                    type: object
                    properties:
                      Success:
                        type: string
                        example: 'Ok'
                400:
                  description: Bad Request
          '/hello-again':
            get:
              summary: Helloing the server
              description: 'Helloing the server 🙋‍♂️'
              operationId: helloAgain
              responses:
                200:
                  description: OK
                  schema:
                    type: object
                    properties:
                      Success:
                        type: string
                        example: 'Ok'
                400:
                  description: Bad Request
      EOF
      )
    }
  }

  gateway_config {
    backend_config {
      google_service_account = local.service_account
    }
  }

  lifecycle {
    create_before_destroy = false
  }

  depends_on = [
    google_project_service.apigateway,
    google_project_service.servicemanagement,
    google_project_service.servicecontrol,
    google_cloud_run_service.service
  ]
}

resource "google_api_gateway_gateway" "api_gw" {
  provider   = google-beta
  api_config = google_api_gateway_api_config.api_cfg.id
  gateway_id = format("%s-api-gw", local.service_alias)

  lifecycle {
    replace_triggered_by = [
      google_api_gateway_api_config.api_cfg.id
    ]
  }

  depends_on = [
    google_api_gateway_api_config.api_cfg
  ]
}
