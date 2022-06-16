variable "gcp_region" {
  type        = string
  description = "GCP region"
}

variable "gcp_project" {
  type        = string
  description = "GCP project name"
}

variable "db_host" {
  type        = string
  description = "DB hostname"
}

variable "db_port" {
  type        = string
  description = "DB port"
}

variable "db_user" {
  type        = string
  description = "DB username"
}

variable "db_name" {
  type        = string
  description = "database name"
}

variable "db_pass_secret" {
  type        = string
  description = "db password secret name"
}