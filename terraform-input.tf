variable "organization" {
  type = string
}

variable "project_id" {
  type = string
}

variable "service_name" {
  type = string
}

variable "service_account" {
  type = string
}

variable "stage" {
  type    = string
  default = "dev-id"
}

variable "image_tag" {
  type    = string
  default = "latest"
}
