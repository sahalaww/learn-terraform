provider "google" {
  project = ""
  credentials = ""
}

# resource "google_service_account" "default" {
#   account_id   = var.sa
#   display_name = var.display_sa
# }

resource "google_compute_instance" "dev-instance" {
  name = "dev-instance"
  machine_type = var.machince_type
  region = var.region
  zone = var.gce_zone
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
  
  metadata_startup_script = data.template_file.deploy.rendered

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    # email  = google_service_account.default.email
    scopes = ["cloud-platform","bigquery","cloud-source-repos", "default","cloud-source-repos-ro", "compute-rw","compute-ro",""]
  }
}

data "template_file" "deploy" {
  template = file("${path.module}/script.sh")
}