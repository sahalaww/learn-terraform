provider "google" {
  credentials = file("cred.json")
  project     = var.project_id
  zone        = var.gce_zone
}

resource "google_compute_network" "andromeda" {
  name                    = "main-vpc-us-central1-a"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "andromeda" {
  name          = "main-vpc-subnet"
  region        = var.region
  network       = google_compute_network.andromeda.self_link
  ip_cidr_range = "10.1.1.0/24"
}

resource "google_compute_firewall" "http-server" {
  name    = "allow-http-server"
  network = google_compute_network.andromeda.self_link

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_instance" "vm-main" {
  name         = "main-andromeda"
  zone         = var.gce_zone
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.andromeda.self_link
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  tags = ["http-server"]

  labels = {
    name = "vm-main"
  }

  metadata_startup_script = data.template_file.jupyter.rendered
}

data "template_file" "jupyter" {
  template = file("${path.module}/startup.sh")
}