variable "credentials_file" {
  description = "Path to GCP credentials JSON"
  type        = string
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "zone" {
  description = "GCP Zone"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}