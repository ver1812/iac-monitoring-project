terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

resource "google_compute_instance" "vm" {
  name         = "iac-monitoring-vm"
  machine_type = "e2-medium"
  tags         = ["iac-vm"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 20
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "ubuntu:${var.ssh_public_key}"
  }
}

resource "google_compute_firewall" "allow_app_ports" {
  name    = "allow-app-ports"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "5000", "5601"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["iac-vm"]
}